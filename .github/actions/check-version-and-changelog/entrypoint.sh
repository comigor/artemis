#!/bin/ash

function debug {
    echo "$1"
}

cd "$GITHUB_WORKSPACE"

ACTIONS_USER_TOKEN="$1"
github_ref="$2"

debug "$(env)"
debug "$(cat "$GITHUB_EVENT_PATH" | jq .)"

PR_CREATOR=$(cat "$GITHUB_EVENT_PATH" | jq -r '.pull_request.user.login')
[ "$PR_CREATOR" = "comigor" ] && EVENT_TYPE="COMMENT" || EVENT_TYPE="REQUEST_CHANGES"

PR_HREF=$(cat "$GITHUB_EVENT_PATH" | jq -r '.pull_request._links.self.href')

function send_message_and_bail {
    ERROR="$1"
    echo "-------------------------------------------------"
    echo "$ERROR"
    echo "-------------------------------------------------"

    if [ ! -z "$ACTIONS_USER_TOKEN" ]; then
        jq -c -n --arg body "$ERROR" --arg event_type "$EVENT_TYPE" '{"event":$event_type, "body":$body}' > /tmp/payload.json
        echo "CURL::"
        cat /tmp/payload.json
        curl -f -X POST \
            -H 'Content-Type: application/vnd.github.v3.full+json' \
            -H "Authorization: Bearer $ACTIONS_USER_TOKEN" \
            --data "@/tmp/payload.json" \
            "$PR_HREF/reviews" -vv
        # || true

    fi

    exit 1
}

debug "PARAM GITHUB REF: $github_ref"
debug "GITHUB EVENT NAME: $GITHUB_EVENT_NAME"
debug "GITHUB REF: $GITHUB_REF"
debug "GITHUB BASE REF: $GITHUB_BASE_REF"
debug "GITHUB HEAD REF: $GITHUB_HEAD_REF"

git fetch --prune --unshallow

if [ "$GITHUB_EVENT_NAME" = "pull_request" ]; then
    where="origin/$github_ref"
else
    where=HEAD~$(jq '.commits | length' "${GITHUB_EVENT_PATH}")
fi

diff=$(git diff $where pubspec.yaml)

echo "$diff" | grep -E '\+.*version' || {
    send_message_and_bail "You must bump the version on pubspec!"
}

package_version=$(cat pubspec.yaml | oq -i YAML -r '.version')

# If are on master or beta
if [ "$github_ref" = "master" ] || [ "$github_ref" = "refs/heads/master" ]; then
    echo "$package_version" | grep "beta" && {
        send_message_and_bail "You can't merge a \"beta\" version on \`master\` branch!"
    }
elif [ "$github_ref" = "beta" ] || [ "$github_ref" = "refs/heads/beta" ]; then
    echo "$package_version" | grep "beta" || {
        send_message_and_bail "You can only merge a \"beta\" version on \`beta\` branch!"
    }
fi

cat CHANGELOG.md | grep -q "$package_version" || {
    send_message_and_bail "Version \`$package_version\` not found on CHANGELOG!"
}

echo "::set-output name=package_version::$package_version"
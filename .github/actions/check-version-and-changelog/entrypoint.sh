#!/bin/ash

cd "$GITHUB_WORKSPACE"

github_ref="$1"
REPO_TOKEN="$2"

echo "PARAM GITHUB REF: $github_ref"
echo "GITHUB EVENT NAME: $GITHUB_EVENT_NAME"
echo "GITHUB REF: $GITHUB_REF"
echo "GITHUB BASE REF: $GITHUB_BASE_REF"
echo "GITHUB HEAD REF: $GITHUB_HEAD_REF"

function send_message_and_bail {
    curl -f -X POST \
        -H 'Content-Type: application/json' \
        -H "Authorization: Bearer $REPO_TOKEN" \
        --data "{\"event\": \"COMMENT\", \"body\": \"$1\"}" \
        "$PR_HREF/reviews"

    exit 1
}

git fetch --prune --unshallow

if [ "$GITHUB_EVENT_NAME" = "pull_request" ]; then
    where="origin/$github_ref"
else
    where=HEAD~$(jq '.commits | length' "${GITHUB_EVENT_PATH}")
fi

diff=$(git diff $where pubspec.yaml)

package_version=$(cat pubspec.yaml | oq -i YAML -r '.version')

echo "$diff" | grep -E '\+.*version' || {
    send_message_and_bail "Version $package_version not bumped on pubspec!"
}

# If are on master or beta
if [ "$github_ref" = "master" ] || [ "$github_ref" = "refs/heads/master" ]; then
    echo "$package_version" | grep "beta" && {
        send_message_and_bail "You can't merge a \"beta\" version on `master` branch!"
    }
elif [ "$github_ref" = "beta" ] || [ "$github_ref" = "refs/heads/beta" ]; then
    echo "$package_version" | grep "beta" || {
        send_message_and_bail "You can only merge a \"beta\" version on `beta` branch!"
    }
fi

cat CHANGELOG.md | grep -q "$package_version" || {
    send_message_and_bail "Version $package_version not found on CHANGELOG!"
}

echo "::set-output name=package_version::$package_version"
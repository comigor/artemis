#!/bin/ash

cd "$GITHUB_WORKSPACE"

github_ref="$1"

echo "PARAM GITHUB REF: $github_ref"
echo "GITHUB EVENT NAME: $GITHUB_EVENT_NAME"
echo "GITHUB REF: $GITHUB_REF"
echo "GITHUB BASE REF: $GITHUB_BASE_REF"
echo "GITHUB HEAD REF: $GITHUB_HEAD_REF"

git fetch --prune --unshallow

if [ "$GITHUB_EVENT_NAME" = "pull_request" ]; then
    where="origin/$github_ref"
else
    where=HEAD~$(jq '.commits | length' "${GITHUB_EVENT_PATH}")
fi

diff=$(git diff $where pubspec.yaml)

echo "$diff" | grep -E '\+.*version' || {
    echo "Version not bumped on pubspec"
    exit 1
}

package_version=$(cat pubspec.yaml | oq -i YAML -r '.version')

# If are on master or beta
if [ "$github_ref" = "master" ] || [ "$github_ref" = "refs/heads/master" ]; then
    echo "$package_version" | grep "beta" && {
        echo "Version cant contain beta"
        exit 1
    }
elif [ "$github_ref" = "beta" ] || [ "$github_ref" = "refs/heads/beta" ]; then
    echo "$package_version" | grep "beta" || {
        echo "Missing beta on version"
        exit 1
    }
fi

cat CHANGELOG.md | grep "$package_version"

echo "::set-output name=package_version::$package_version"
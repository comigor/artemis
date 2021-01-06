#!/bin/bash

set -eu

REPO_TOKEN="$1"
DTA_IS_FLUTTER="$2"
DTA_DISABLE_LINTER="$3"
DTA_DISABLE_ANALYZER="$4"
DTA_DISABLE_TESTS="$5"
DTA_EXCLUDE_REGEX="$6"

echo "DTA_IS_FLUTTER=$DTA_IS_FLUTTER"
echo "DTA_DISABLE_LINTER=$DTA_DISABLE_LINTER"
echo "DTA_DISABLE_ANALYZER=$DTA_DISABLE_ANALYZER"
echo "DTA_DISABLE_TESTS=$DTA_DISABLE_TESTS"
echo "DTA_EXCLUDE_REGEX=$DTA_EXCLUDE_REGEX"

cd "$GITHUB_WORKSPACE"

PR_HREF=$(cat "$GITHUB_EVENT_PATH" | jq -r '.pull_request._links.self.href')

function send_message_and_bail {
    ERROR="$1"
    DETAIL="$2"

    if [ ! -z "$REPO_TOKEN" ]; then
        BODY=$(cat <<EOF
$ERROR

<details>
<pre>
$DETAIL
</pre>
</details>
EOF
)

        jq -c -n --arg body "$BODY" '{"event":"COMMENT", "body":$body}' > /tmp/payload.json
        curl -f -X POST \
            -H 'Content-Type: application/json' \
            -H "Authorization: Bearer $REPO_TOKEN" \
            --data "@/tmp/payload.json" \
            "$PR_HREF/reviews" -vv || true
    fi

    echo "------------------------------------------------"
    echo "$ERROR"
    echo "$DETAIL"
    echo "------------------------------------------------"
    exit 1
}

for ppath in $(find . -name pubspec.yaml | grep -ve "$DTA_EXCLUDE_REGEX"); do
  echo "=== On $ppath ==="
  cd $(dirname "$ppath");

  echo "=== Downloading dependencies ==="
  if [ "$DTA_IS_FLUTTER" = "false" ]; then
    pub get
  else
    flutter pub get
  fi

  if [ "$DTA_DISABLE_LINTER" = "false" ]; then
    echo "=== Running linter ==="
    OUTPUT=$(dartfmt -n . --set-exit-if-changed 2>&1)

    if [ $? -ne 0 ]; then
        send_message_and_bail "Linter has failed! \`dartfmt -n . --set-exit-if-changed\`:" "$OUTPUT"
    fi
  fi

  if [ "$DTA_DISABLE_ANALYZER" = "false" ]; then
    echo "=== Running analyzer ==="
    OUTPUT=$(dartanalyzer --fatal-infos --fatal-warnings . 2>&1) || send_message_and_bail "Analyzer has failed! \`dartanalyzer --fatal-infos --fatal-warnings .\`:" "$OUTPUT"
  fi

  [ -d "test" ] && {
    if [ "$DTA_DISABLE_TESTS" = "false" ]; then
      echo "=== Running tests ==="
      if [ "$DTA_IS_FLUTTER" = "false" ]; then
        OUTPUT=$(pub run test --no-color -r expanded 2>&1) || send_message_and_bail "Tests failed!" "$OUTPUT"
      else
        OUTPUT=$(flutter test 2>&1) || send_message_and_bail "Tests have failed! \`pub run test\`:" "$OUTPUT"
      fi
    fi
  }

  # Go back
  cd -
done
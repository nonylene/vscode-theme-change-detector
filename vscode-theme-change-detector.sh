#!/usr/bin/env bash

set -e

[ -z "$VSCODE_DETECTOR_REV" ] && echo "Environment variable VSCODE_DETECTOR_REV required" && exit 1
[ -z "$VSCODE_DETECTOR_SLACK_WEBHOOK_URL" ] && echo "Environment variable VSCODE_DETECTOR_SLACK_WEBHOOK_URL required" && exit 1

if [ ! -d ./vscode ]; then
  git clone https://github.com/Microsoft/vscode vscode
fi

cd vscode

git fetch

if ! (git diff --exit-code --quiet $VSCODE_DETECTOR_REV origin/master extensions/theme-defaults/themes/dark_defaults.json &&
  git diff --exit-code --quiet $VSCODE_DETECTOR_REV origin/master extensions/theme-monokai/themes/monokai-color-theme.json) ; then
  echo "Changed!!"

  default_diff=`git diff $VSCODE_DETECTOR_REV origin/master extensions/theme-defaults/themes/dark_defaults.json`
  monokai_diff=`git diff $VSCODE_DETECTOR_REV origin/master extensions/theme-monokai/themes/monokai-color-theme.json`

  text=$(cat <<EOF
VSCode change detected!
- https://github.com/Microsoft/vscode/blob/master/extensions/theme-defaults/themes/dark_defaults.json
\`\`\`
$default_diff
\`\`\`
- https://github.com/Microsoft/vscode/blob/master/extensions/theme-monokai/themes/monokai-color-theme.json
\`\`\`
$monokai_diff
\`\`\`
EOF
)

  payload=$(jq -n --arg text "$text" '{"channel": "#webhooks", "username": "vscode-theme-detection", "text": $text, "icon_emoji": ":octopus:"}')
  echo $payload

  curl -s -X POST --data-urlencode "payload=$payload" "$VSCODE_DETECTOR_SLACK_WEBHOOK_URL"
fi

#! /bin/bash

set -eu -o pipefail

REVERT=false

while test $# -gt 0; do
  case "$1" in
    --revert)
      REVERT=true
      shift
      ;;
    *)
      break
      ;;
  esac
done

JS_START="// First make sure the wrapper app is loaded"

JS="
${JS_START}
var fs = require('fs');
const filePath = '/Users/apesic/src/dotfiles/slack_dark.css';
document.addEventListener('DOMContentLoaded', () => {
  fs.readFile(filePath, {encoding: 'utf-8'}, (err, data) => {
    if (!err) {
      var css = document.createElement('style');
      css.innerText = data;
      document.getElementsByTagName('head')[0].appendChild(css);
    }
  })
});
"

OSX_SLACK_RESOURCES_DIR="/Applications/Slack.app/Contents/Resources"
LINUX_SLACK_RESOURCES_DIR="/usr/lib/slack/resources"

if [[ -d $OSX_SLACK_RESOURCES_DIR ]]; then SLACK_RESOURCES_DIR=$OSX_SLACK_RESOURCES_DIR; fi
if [[ -d $LINUX_SLACK_RESOURCES_DIR ]]; then SLACK_RESOURCES_DIR=$LINUX_SLACK_RESOURCES_DIR; fi

SLACK_FILE_PATH="${SLACK_RESOURCES_DIR}"/app.asar.unpacked/dist/ssb-interop.bundle.js

# Check if commands exist
if ! command -v node >/dev/null 2>&1; then
  echo "Node.js is not installed. Please install before continuing."
  exit 1
fi
if ! command -v npm >/dev/null 2>&1; then
  echo "npm is not installed. Please install before continuing."
  exit 1
fi
if ! command -v npx >/dev/null 2>&1; then
  echo "npx is not installed. run `npm i -g npx` to install."
  exit 1
fi

if [ "$REVERT" = true ]; then
echo "Bringing Slack into the light... "
else
echo "Bringing Slack into the darknesss... "
fi

sudo npx asar extract "${SLACK_RESOURCES_DIR}"/app.asar "${SLACK_RESOURCES_DIR}"/app.asar.unpacked

if [ "$REVERT" = true ]; then
  sudo sed -i.backup '1,/\/\/# sourceMappingURL=ssb-interop.bundle.js.map/!d' "${SLACK_FILE_PATH}"
else
  sudo tee -a "${SLACK_FILE_PATH}" > /dev/null <<< "$JS"
fi

sudo npx asar pack "${SLACK_RESOURCES_DIR}"/app.asar.unpacked "${SLACK_RESOURCES_DIR}"/app.asar

echo ""
echo "Slack Updated! Refresh or reload slack to see changes"


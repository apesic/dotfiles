#! /bin/bash

# Based on https://gist.github.com/DrewML/0acd2e389492e7d9d6be63386d75dd99
path='/Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js'

script=$(cat <<'EOF'
var fs = require('fs');
const filePath = '/Users/apesic/dotfiles/slack_dark.css';
document.addEventListener('DOMContentLoaded', () => {
  fs.readFile(filePath, {encoding: 'utf-8'}, (err, data) => {
    if (!err) {
      var css = document.createElement('style');
      css.innerText = data;
      document.getElementsByTagName('head')[0].appendChild(css);
    }
  })
});
'EOF'
)

if grep -qF "apesic" $path; then
  echo "Resource already present, skipping."
else
  echo $script >> $path
fi

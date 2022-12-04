#!/bin/bash

apk add curl jq

[[ ! -f EXISTING ]] || touch EXISTING
EXISTING=$(cat EXISTING)
echo "Existing: ${EXISTING}"

if [[ -n $OVERWRITE ]]; then
  echo "Overwriting: $OVERWRITE"
  LATEST=$OVERWRITE
else
  NAME=$(curl -ks https://api.github.com/repos/webtorrent/bittorrent-tracker/git/refs/tags | jq -r ".[-1].ref")
  LATEST=${NAME/refs\/tags\//}
  echo "Latest: ${LATEST}"
fi

if [[ (-n "${LATEST}" && "${LATEST}" != "${EXISTING}") ]]; then
  mv build.template.yml build.yml
  sed -i "s \$LATEST ${LATEST} g" 'build.yml'

  echo "Building..."
fi

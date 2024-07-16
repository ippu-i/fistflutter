#!/bin/bash
set -euxo pipefail

# Flutter
CHANNEL="stable" # or "beta"

TAGS=$(gh api repos/flutter/flutter/git/refs/tags --paginate | jq -r '.[].ref' | sed 's/refs\/tags\///' | grep '^[0-9].*')

## Search latest tag
if [ "$CHANNEL" = "beta" ]; then
    TARGET_TAG=$(echo "$TAGS" | grep '\.pre$' | sort -V | tail -n 1)
elif [ "$CHANNEL" = "stable" ]; then
    TARGET_TAG=$(echo "$TAGS" | grep -v '\.pre$' | sort -V | tail -n 1)
else
    echo "CHANNEL is invalid."
    exit 1
fi

## Install Flutter
git clone https://github.com/flutter/flutter.git --depth 1 --branch "$TARGET_TAG" "$HOME/flutter"

export PATH=$PATH:/home/codespace/flutter/bin/

flutter --version

flutter pub global activate melos
flutter pub global activate grinder
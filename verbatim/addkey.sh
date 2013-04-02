#!/bin/bash

set -o errexit
set -o nounset

IMAGE="$1"

source config.sh

LOOP=`losetup --find --show --offset "$ENC_START" --sizelimit "$ENC_LIMIT" "$IMAGE"`
#TODO: Use a passphrase-less keyfile?
cryptsetup luksAddKey "$LOOP"
losetup -d "$LOOP"


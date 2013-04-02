#!/bin/bash
set -o errexit
set -o nounset

IMAGE="$1" # Full disk image file

source config.sh

# --find --show uses and prints the first available loop device
LOOP=`losetup --find --show --offset "$ENC_START" --sizelimit "$ENC_LIMIT" --read-only "$IMAGE"`
echo "Using loop device: $LOOP"

cryptsetup luksOpen $LOOP "$CRYPT_NAME"
echo "Unlocked as device '$CRYPT_NAME'"

vgchange --available y "$LVM_GROUP"
lvscan
echo "Opened LVM volume group"

mkdir -p "$MOUNTPT"
echo "Created mountpoint $MOUNTPT"

mount /dev/thunkvg/ozzie "$MOUNTPT"
echo "Mounted /"

mount /dev/thunkvg/sweethome "$MOUNTPT"/home
echo "Mounted /home"

echo "Done. Remember to pass $LOOP to the unmount script."


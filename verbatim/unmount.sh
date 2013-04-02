#!/bin/bash
set -o errexit
set -o nounset

LOOP="$1" # the loop device to be closed

source config.sh

umount "$MOUNTPT"/home
echo "Unmounted /home"

umount "$MOUNTPT"
echo "Unmounted /"

rmdir "$MOUNTPT"
echo "Removed mountpoint $MOUNTPT"

vgchange --available n "$LVM_GROUP"
echo "Closed LVM volume group"

cryptsetup luksClose "$CRYPT_NAME"
echo "Locked encrypted partition"

losetup -d $LOOP
echo "Removed loop device"


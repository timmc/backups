#!/bin/bash

# Found using parted : unit B
# The encrypted partition is the first logical partition (sda5):
# 5      35501637632B  320072581119B  284570943488B  logical
ENC_START=35501637632
ENC_LIMIT=284570943488

CRYPT_NAME=natty
LVM_GROUP=thunkvg
MOUNTPT=/mnt/natty


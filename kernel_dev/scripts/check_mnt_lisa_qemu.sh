#!/bin/bash


###########################################################
################### variables defines #####################
###########################################################

PROG_NAME="$(basename $0)"
TOPDIR="$(dirname $0)/../"
SCRIPT_DIR="$(realpath $TOPDIR)"/scripts

. $SCRIPT_DIR/env_lisa_qemu.sh

###########################################################
################### functions defines #####################
###########################################################
function usage()
{
	echo "Usage: $PROG_NAME [options]"
	echo -e "\toptions:"
	echo -n -e "\t -h \t\t Print this message.\n";
	echo -n -e "\t -r [ARG] \t Specified lisa-qemu root directory. (default: $LISA_QEMU_ROOT) \n"
	echo -n -e "\t -I [ARG] \t Specified lisa-qemu image. (default: $LISA_QEMU_BUILD_ROOT/$LISA_QEMU_IMAGE_NAME).\n"
	echo -n -e "\t -d [ARG] \t Mount Directory (default: (default: $LISA_QEMU_BUILD_ROOT/mnt).\n"

	echo -e "\nExample: "
	echo -e "\t./$PROG_NAME"
	echo -e "\t./$PROG_NAME -r ./test_root"
	echo -e "\t./$PROG_NAME -r ./test_root -I image.img"
	echo -e "\t./$PROG_NAME -g"
}


###########################################################
################### Start Main Program ####################
###########################################################

PARSED_ARGUMENTS=$(getopt -a \
	-o d:I:r:h \
	-n "$PROG_NAME" -- "$@"
)

LISA_QEMU_IMAGE=$LISA_QEMU_BUILD_ROOT/$LISA_QEMU_IMAGE_NAME
LISA_QEMU_IMAGE_RAW=$LISA_QEMU_IMAGE.raw
LISA_QEMU_MOUNT_POINT=$LISA_QEMU_BUILD_ROOT/mnt

eval set --$PARSED_ARGUMENTS

while [[ $# -gt 0 ]]; do
	case "$1" in
		-h)
			usage
			shift 1
			;;
		-r)
			LISA_QEMU_ROOT="$(realpath $2)"
			LISA_QEMU_BUILD_ROOT="$LISA_QEMU_ROOT"/build/VM-ubuntu.aarch64
			LISA_QEMU_IMAGE=$LISA_QEMU_BUILD_ROOT/$LISA_QEMU_IMAGE_NAME
			LISA_QEMU_IMAGE_RAW=$LISA_QEMU_IMAGE.raw
			LISA_QEMU_MOUNT_POINT=$LISA_QEMU_BUILD_ROOT/mnt
			shift 2
			;;
		-I)
			LISQ_QEMU_IMAGE="$(realpath $2)"
			LISA_QEMU_IMAGE_RAW=$LISA_QEMU_IMAGE.raw
			GENERATE_IMAGE=y
			shift 2
			;;
		-d)
			LISA_QEMU_MOUNT_POINT="$(realpath $2)"
			shift 2
			;;
		--)
			shift
			break
			;;
		*)
			break
			;;
	esac
done


if [[ ! -d "$LISA_QEMU_MOUNT_POINT" ]]; then
		echo "[ERROR] No mount point!"

	exit 1;
fi

sudo losetup -l | grep "$LISA_QEMU_IMAGE_RAW" > /dev/null
if [[ $? != 0 ]]; then
	exit 1;
fi

LOOP_DEVICE=$(sudo losetup -l | grep "$LISA_QEMU_IMAGE_RAW"| grep -v grep | awk '{print $1}')
if [[ -z "$LOOP_DEVICE" ]]; then
	exit 1;
fi

LOOP_DEVICE="$LOOP_DEVICE"p1

mount | grep $LOOP_DEVICE | grep $LISA_QEMU_MOUNT_POINT > /dev/null

if [[ $? != 0 ]]; then
	exit 1;
fi

exit 0;

#!/bin/bash


###########################################################
################### variables defines #####################
###########################################################

PROG_NAME="$(basename $0)"
TOPDIR="$(dirname $0)/../"
SCRIPT_DIR="$(realpath $TOPDIR)"/scripts

. $SCRIPT_DIR/env_lisa_qemu.sh

QEMU_IMG="$(which qemu-img)"

###########################################################
################### functions defines #####################
###########################################################
function usage()
{
	echo "Usage: $PROG_NAME [options]"
	echo -e "\toptions:"
	echo -n -e "\t -h \t\t Print this message.\n";
	echo -n -e "\t -r [ARG] \t Specified lisa-qemu root directory. (default: $LISA_QEMU_ROOT) \n"
	echo -n -e "\t -I [ARG] \t Specified lisa-qemu image.  (default: $LISA_QEMU_BUILD_ROOT/$LISA_QEMU_IMAGE_NAME).\n"
	echo -n -e "\t -d [ARG] \t Mount Directory  (default: (default: $LISA_QEMU_BUILD_ROOT/mnt).\n"

	echo -e "\nExample: "
	echo -e "\t./$PROG_NAME"
	echo -e "\t./$PROG_NAME -r ./test_root"
	echo -e "\t./$PROG_NAME -r ./test_root -I image.img"
	echo -e "\t./$PROG_NAME -d"
}


###########################################################
################### Start Main Program ####################
###########################################################

PARSED_ARGUMENTS=$(getopt -a \
	-o r:I:d:h \
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

if [[ -z "$QEMU_IMG" ]]; then
	QEMU_IMG=$LISA_QEMU_ROOT/external/qemu/build/qemu-img
fi

if [[ ! -d "$LISA_QEMU_MOUNT_POINT" ]]; then
	mkdir -p "$LISA_QEMU_MOUNT_POINT"
fi

if [[ ! -f "$LISA_QEMU_IMAGE_RAW" ]]; then
	$QEMU_IMG convert -p -O raw "$LISA_QEMU_IMAGE" "$LISA_QEMU_IMAGE_RAW"
	if [[ $? != 0 ]]; then
		echo "[ERROR] Fail to convert image from qcow2 to raw"

		exit 1;
	fi
fi

sudo losetup -l | grep "$LISA_QEMU_IMAGE_RAW"
if [[ $? != 0 ]]; then
	sudo losetup -f -P "$LISA_QEMU_IMAGE_RAW"
fi

LOOP_DEVICE=$(sudo losetup -l | grep "$LISA_QEMU_IMAGE_RAW"| grep -v grep | awk '{print $1}')
if [[ -z "$LOOP_DEVICE" ]]; then
	echo "[ERROR] Fail to find out loop device!"

	exit 1;
else
	LOOP_DEVICE="$LOOP_DEVICE"p1
fi
sudo mount -orw "$LOOP_DEVICE" "$LISA_QEMU_MOUNT_POINT"

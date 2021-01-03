#!/bin/bash


###########################################################
################### variables defines #####################
###########################################################

PROG_NAME="$(basename $0)"
TOPDIR="$(dirname $0)/../"
SCRIPT_DIR="$(realpath $TOPDIR)"/scripts

. $SCRIPT_DIR/env_lisa_qemu.sh

DEBUG_OPTION=

QEMU_SYSTEM_AARCH64="$(which qemu-system-aarch64)"

###########################################################
################### functions defines #####################
###########################################################
function usage()
{
	echo "Usage: $PROG_NAME [options]"
	echo -e "\toptions:"
	echo -n -e "\t -h \t\t Print this message.\n";
	echo -n -e "\t -d \t\t Run lisa-qemu for debugging.\n";
	echo -n -e "\t -r [ARG] \t Specified lisa-qemu root directory. (default: $LISA_QEMU_ROOT) \n"
	echo -n -e "\t -I [ARG] \t Specified lisa-qemu image.  (default: $LISA_QEMU_BUILD_ROOT/$LISA_QEMU_IMAGE_NAME).\n"
	echo -n -e "\t -k [ARG] \t Specified lisa-qemu kernel. (default: $LISA_QEMU_BUILD_ROOT/$LISA_QEMU_KERNEL_NAME).\n"
	echo -n -e "\t -i [ARG] \t Specified lisa-qemu initrd. (default: $LISA_QEMU_BUILD_ROOT/$LISA_QEMU_INITRD_NAME).\n"

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
	-o r:I:k:i:dh \
	-n "$PROG_NAME" -- "$@"
)

LISA_QEMU_IMAGE=$LISA_QEMU_BUILD_ROOT/$LISA_QEMU_IMAGE_NAME
LISA_QEMU_KERNEL=$LISA_QEMU_BUILD_ROOT/$LISA_QEMU_KERNEL_NAME
LISA_QEMU_INITRD=$LISA_QEMU_BUILD_ROOT/$LISA_QEMU_INITRD_NAME

eval set --$PARSED_ARGUMENTS

while [[ $# -gt 0 ]]; do
	case "$1" in
		-h)
			usage
			shift 1

			exit 0
			;;
		-d)
			DEBUG_OPTION="-s -S"
			shift 1
			;;
		-r)
			LISA_QEMU_ROOT="$(realpath $2)"
			LISA_QEMU_BUILD_ROOT="$LISA_QEMU_ROOT"/build/VM-ubuntu.aarch64
			LISA_QEMU_IMAGE=$LISA_QEMU_BUILD_ROOT/$LISA_QEMU_IMAGE_NAME
			LISA_QEMU_KERNEL=$LISA_QEMU_BUILD_ROOT/$LISA_QEMU_KERNEL_NAME
			LISA_QEMU_INITRD=$LISA_QEMU_BUILD_ROOT/$LISA_QEMU_INITRD_NAME

			shift 2
			;;
		-I)
			LISQ_QEMU_IMAGE="$(realpath $2)"
			shift 2
			;;
		-k)
			LISQ_QEMU_KERNEL="$(realpath $2)"
			shift 2
			;;
		-i)
			LISQ_QEMU_INITRD="$(realpath $2)"
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

if [[ -z "$QEMU_SYSTEM_AARCH64" ]]; then
	QEMU_SYSTEM_AARCH64=$LISA_QEMU_ROOT/external/qemu/build/aarch64-softmmu/qemu-system-aarch64
fi

QEMU_PID=$(ps -ef | grep qemu | grep -v grep | grep -v run | awk '{print $2}')

if [[ ! -z "$QEMU_PID" ]]; then
	echo "[ERROR] LISA-QEMU is already running pid: $QEMU_PID"

	exit 1
fi


COMMAND="$QEMU_SYSTEM_AARCH64 -machine virt,gic-version=3 -m 2G -cpu max \
	-drive file=$LISA_QEMU_IMAGE,if=none,id=drive0,cache=writeback \
	-device virtio-blk,drive=drive0,bootindex=0 \
	-drive file=$LISA_QEMU_FLSAH_0,format=raw,if=pflash \
	-drive file=$LISA_QEMU_FLSAH_1,format=raw,if=pflash \
	-smp cpus=2,cores=1 \
	-kernel $LISA_QEMU_KERNEL \
	-initrd $LISA_QEMU_INITRD \
	-nographic \
	$DEBUG_OPTION"

$COMMAND

#!/bin/bash


###########################################################
################### variables defines #####################
###########################################################

PROG_NAME="$(basename $0)"
TOPDIR="$(dirname $0)/../"
SCRIPT_DIR="$(realpath $TOPDIR)"/scripts

. $SCRIPT_DIR/env_lisa_qemu.sh

DD="$(which dd)"
QEMU_EFI_IMG="/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"


###########################################################
################### functions defines #####################
###########################################################
function usage()
{
	echo "Usage: $PROG_NAME [options]"
	echo -e "\toptions:"
	echo -n -e "\t -h \t\t Print this message.\n";
	echo -n -e "\t -r [ARG] \t Specified lisa-qemu root directory. (default: $LISA_QEMU_ROOT) \n"

	echo -e "\nExample: "
	echo -e "\t./$PROG_NAME"
	echo -e "\t./$PROG_NAME -r ./test_root"
}


###########################################################
################### Start Main Program ####################
###########################################################

PARSED_ARGUMENTS=$(getopt -a \
	-o r:h \
	-n "$PROG_NAME" -- "$@"
)

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
			LISA_QEMU_FLSAH_0=$LISA_QEMU_BUILD_ROOT/flash2.img
			LISA_QEMU_FLSAH_1=$LISA_QEMU_BUILD_ROOT/flash3.img
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


stat "$QEMU_EFI_IMG" > /dev/null
if [[ $? != 0 ]]; then
	echo "[ERROR] No QEMU_EFI.img. Please install qemu using apt-get"

	exit 1;
fi

rm -f "$LISA_QEMU_FLSAH_0"
rm -f "$LISA_QEMU_FLSAH_1"

dd if=/dev/zero of="$LISA_QEMU_FLSAH_0" bs=1M count=64
if [[ $? != 0 ]]; then
	echo "[ERROR] Fail to generated $LISA_QEMU_FLSAH_0"

	exit 1;
fi

dd if="$QEMU_EFI_IMG" of="$LISA_QEMU_FLSAH_0" conv=notrunc
if [[ $? != 0 ]]; then
	echo "[ERROR] Fail to copy QEMU_EFI_IMG to  $LISA_QEMU_FLSAH_0"
	rm -f "$LISA_QEMU_FLSAH_0"

	exit 1;
fi

dd if=/dev/zero of="$LISA_QEMU_FLSAH_1" bs=1M count=64
if [[ $? != 0 ]]; then
	echo "[ERROR] Fail to generated $LISA_QEMU_FLSAH_1"
	rm -f "$LISA_QEMU_FLSAH_0"
	rm -f "$LISA_QEMU_FLSAH_1"

	exit 1;
fi

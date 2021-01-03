#!/bin/bash

###########################################################
################### variables defines #####################
###########################################################

LISA_QEMU_ROOT="$(realpath ../lisa-qemu)"
LISA_QEMU_BUILD_ROOT="$LISA_QEMU_ROOT"/build/VM-ubuntu.aarch64

LISA_QEMU_IMAGE_NAME=ubuntu.aarch64.img.kernel-5.10.0+-2
LISA_QEMU_KERNEL_NAME=ubuntu.aarch64.img.kernel-5.10.0+-2
LISA_QEMU_INITRD_NAME=initrd.img-5.10.0+-2

LISA_QEMU_FLSAH_0=$LISA_QEMU_BUILD_ROOT/flash0.img
LISA_QEMU_FLSAH_1=$LISA_QEMU_BUILD_ROOT/flash1.img

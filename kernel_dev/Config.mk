CROSS_COMPILE_GLIBCDIR=/home/levi/tool/sysroot-glibc-linaro-2.25-2019.12-aarch64-linux-gnu
CROSS_COMPILE_DIR=/home/levi/tool/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu
CROSS_COMPILE_PREFIX=aarch64-linux-gnu-
CROSS_COMPILE=$(CROSS_COMPILE_DIR)/bin/$(CROSS_COMPILE_PREFIX)

ARCH=arm64
AS=$(CROSS_COMPILE)as
LD=$(CROSS_COMPILE)ld
CC=$(CROSS_COMPILE)gcc
CXX=$(CROSS_COMPILE)g++
AR=$(CROSS_COMPILE)ar
NM=$(CROSS_COMPILE)nm
STRIP=$(CROSS_COMPILE)strip
RANLIB=$(CROSS_COMPILE)ranlib
OBJCOPY=$(CROSS_COMPILE)objcopy
OBJDUMP=$(CROSS_COMPILE)objdump


SYSTEM_ROOT ?= $(TOPDIR)/system_root
SYSTEM_ROOT_USR ?= $(TOPDIR)/system_root/usr
SYSTEM_ROOT_INCLUDE ?= $(TOPDIR)/system_root/usr/include

# Below flags will be used in user programs.
CONFIG_OPT_BUILD ?= x86_64-linux-gnu
CONFIG_OPT_HOST ?= aarch64-linux-gnu

CONFIG_OPT_CFLAGS := -nostdinc
CONFIG_OPT_CFLAGS += -I$(SYSTEM_ROOT_INCLUDE)
CONFIG_OPT_CFLAGS += -I$(CROSS_COMPILE_DIR)/aarch64-linux-gnu/libc/usr/include
CONFIG_OPT_CFLAGS += -I$(CROSS_COMPILE_DIR)/aarch64-linux-gnu/include
CONFIG_OPT_CFLAGS += -I$(CROSS_COMPILE_DIR)/lib/gcc/aarch64-linux-gnu/7.5.0/include
CONFIG_OPT_CFLAGS += -I$(CROSS_COMPILE_DIR)/lib/gcc/aarch64-linux-gnu/7.5.0/include-fixed
CONFIG_OPT_CFLAGS += -I$(CROSS_COMPILE_DIR)/lib/gcc/aarch64-linux-gnu/7.5.0/install-tools/include

CONFIG_OPT_CXXFLAGS := -nostdinc++
CONFIG_OPT_CXXFLAGS += $(CONFIG_OPT_CFLAGS)
CONFIG_OPT_CXXFLAGS += -I$(CROSS_COMPILE_DIR)/aarch64-linux-gnu/include/c++/7.5.0
CONFIG_OPT_CXXFLAGS += -I$(CROSS_COMPILE_DIR)/aarch64-linux-gnu/include/c++/7.5.0/aarch64-linux-gnu
CONFIG_OPT_CXXFLAGS += -I$(CROSS_COMPILE_DIR)/aarch64-linux-gnu/include/c++/7.5.0/backward


# Add library path you want to linking.
# default linking path is already included in CROSS-COMPILER options.
CONFIG_OPT_LDFLAGS :=

# Defaults JOB
JOBS=8


# for lisa-qemu
LISA_QEMU_ROOT ?= $(shell realpath lisa-qemu)
LISA_QEMU_SCRIPTS ?= $(LISA_QEMU_ROOT)/scripts
LISA_QEMU_BUILD ?= $(LISA_QEMU_ROOT)/build
LISA_IMAGE_ROOT ?= $(LISA_QEMU_BUILD)/VM-ubuntu.aarch64
LISA_IMAGE_MOUNTPOINT ?= $(LISA_QEMU_BUILD)/VM-ubuntu.aarch64/mnt

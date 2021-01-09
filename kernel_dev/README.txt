===============
0. Introduction
===============
This build system is to analysis aarch64 linux-kernel for iamroot 17th.
For usage, Please see the usage printout by "make help" on TOPDIR.
To use this enviroment we require at least...:
    1. Host OS should be ubuntu or debian series.
    2. Require more than 70GB free space.
    3. At least have 2 CPU or more.
    4. At least have 2GB free memory.

================================
1. CROSS_COMPILE toolchain setup
================================
    1. wget https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz
       wget https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/sysroot-glibc-linaro-2.25-2019.12-aarch64-linux-gnu.tar.xz
    2. Untar above two files (tar xvf ...).
    3. cd TOPDIR
    4. edit Config.mk's CROSS_COMPILE_GLIBCDIR and CROSS_COMPILE_DIR with above untared directory.

====================
2. Required Packages
====================
sudo apt-get build-dep -y qemu
sudo apt-get install -y libfdt-dev flex bison git apt-utils
sudo apt-get install -y python3-yaml wget qemu-efi-aarch64 qemu-utils genisoimage qemu-user-static

====================
3. LISA-QEMU INSTALL
====================
To install lisa-qemu please follow orders in TOPDIR.
  1. git clone https://github.com/rf972/lisa-qemu.git
  2. copy conf/config_default.yml to lisa-qemu/conf
  3. cd lisq-qemu
  4. git submodule update --init --recursive
  5. cd scripts
  6. python3 build_image.py (this build qemu in lisa-qemu. take long time...)
  7. cd TOPDIR/scripts
  8. run init_flash_lisa_qemu.sh for generating bootloader.
  9. edit env_lisa_qemu.sh's env variables properly.
  10. sudo mount_lisa_qemu.sh
  11. cd TOPDIR/lisa-qemu/build/VM-ubuntu.aarch64/mnt/etc/default
  12. edit below line of grub file.
          GRUB_CMDLINE_LINUX_DEFAULT
      TO
          GRUB_CMDLINE_LINUX_DEFAULT="root=/dev/vda1 nokaslr console=ttyAMA0"
      This modification disable KASLR to debug linux kernel.

  13. cd TOPDIR/scripts
  14. sudo umount_lisa_qemu.sh -g

=========================
4. KERNEL BUILD & INSTALL
=========================
    1. cd TOPDIR
    2. mkdir linux && cd linux
    3. git clone https://github.com/torvalds/linux.git && mv linux src
    4. cd TOPDIR
    5. make config-kernel
    6. make build-kernel
    7. make install-kernel-headers
    8. make package-kernel (this makes debian package)
    9. make install-kernel KERNEL_PACKAGE={pkg}
       You could get {pkg} by "ls -al TOPDIR/linux"
    10. cd TOPDIR/scripts
    11. edit env_lisa_qemu.sh's env variables properly.

=========================
5. RUN LISA-QEMU
=========================
    1. cd TOPDIR/scripts
    2. ./run_lisa_qemu.sh     ======> normal running
    3. ./run_lisa_qemu.sh -d  ======> debug running (should be attached with gdb)
    4. For more detail about debugging kernel, see section 7. Using GDB

=========================
6. KILL LISA-QEMU
=========================
    1. cd TOPDIR/scripts
    2. ./kill_lisa_qemu.sh

=========================
7. Using GDB
=========================
    1. Install gef (https://github.com/hugsy/gef).

       If you use gdb in tool-chains you've downloaded, install
       gef-legacy (https://github.com/hugsy/gef-legacy).

    2. ./run_lisa_qemu.sh -d
    3. Run aarch64-linux-gnu-gdb (if you use Ubuntu as host O/S, use gdb-multiarch instead)
    4. file $TOPDIR/linux/src/vmlinux
    5. target remote :1234
    6. b start_kernel
    7. continue

=========================
8. REFERENCES
=========================
lisa-qemu: https://github.com/rf972/lisa-qemu

TOPDIR=$(shell pwd)

include ./Config.mk

# default directores information
SCRIPTS_DIR=$(TOPDIR)/scripts

# for linux-kenrel build.
KERNEL_SRC = linux

# for userland programs
SRCS = libaudit

# Override variables
KERNEL_PACKAGE ?= $(KERNEL_SRC)/linux-image-5.10.0+_5.10.0+-2_arm64.deb


JOBS_CORE = -j$(JOBS)

export ARCH
export CROSS_COMPILE
export JOBS_CORE
export SYSTEM_ROOT


# helper functino define.
reverse = $(if $(1),$(call reverse,$(wordlist 2,$(words $(1)),$(1)))) $(firstword $(1))


# Rule
init_system_root:
	@mkdir -p $(SYSTEM_ROOT)
	@mkdir -p $(SYSTEM_ROOT)/lib
	@mkdir -p $(SYSTEM_ROOT)/usr/lib


exit_system_root:
	@rm -rf $(SYSTEM_ROOT)


config-kernel: init_system_root
	@cp $(TOPDIR)/conf/default-config.aarch64 $(KERNEL_SRC)/src/.config


build-kernel: config-kernel
	$(MAKE) -C $(KERNEL_SRC)/src V=1 all $(JOBS_CORE)
	$(MAKE) -C $(KERNEL_SRC)/src INSTALL_HDR_PATH=$(SYSTEM_ROOT_USR) headers_install


install-kernel-headers: init_system_root
	$(MAKE) -C $(KERNEL_SRC)/src INSTALL_HDR_PATH=$(SYSTEM_ROOT_USR) headers_install


package-kernel: build-kernel
	$(MAKE) -C $(KERNEL_SRC)/src bindeb-pkg $(JOBS_CORE)


install-kernel:
	if [ ! -f $(KERNEL_PACKAGE) ]; then\
		echo "[ERROR] Please specified kernel package!"; \
		exit 1; \
	fi
	sudo python3 $(LISA_QEMU_SCRIPTS)/install_kernel.py -p $(KERNEL_PACKAGE)


clean-kernel:
	$(MAKE) -C $(KERNEL_SRC)/src clean


config: init_system_root $(patsubst %,config-%, $(SRCS))
$(patsubst %,config-%, $(SRCS)): init_system_root
	$(MAKE) -C $(patsubst config-%,%,$@) config


build: $(patsubst %,build-%, $(SRCS))
$(patsubst %,build-%, $(SRCS)):
	$(MAKE) -C $(patsubst build-%,%,$@) build


install: $(patsubst %,install-%, $(SRCS))
$(patsubst %,install-%, $(SRCS)):
	$(MAKE) -C $(patsubst install-%,%,$@) install


uninstall: $(call reverse, $(patsubst %,uninstall-%, $(SRCS)))
$(patsubst %,uninstall-%, $(SRCS)):
	$(MAKE) -C $(patsubst uninstall-%,%,$@) uninstall


clean: $(call reverse, $(patsubst %,clean-%, $(SRCS)))
$(patsubst %,clean-%, $(SRCS)): exit_system_root
	$(MAKE) -C $(patsubst clean-%,%,$@) clean


reimage:
	$(eval RET=$(shell $(SCRIPTS_DIR)/check_mnt_lisa_qemu.sh || echo $$?))
	@if [ ! -z "$(RET)" ]; then\
		sudo $(SCRIPTS_DIR)/mount_lisa_qemu.sh; \
	fi
	@sudo cp -RP $(SYSTEM_ROOT)/* $(LISA_IMAGE_MOUNTPOINT)
	@sudo $(SCRIPTS_DIR)/umount_lisa_qemu.sh -g

help:
	@echo -n "Kernel\n"
	@echo -n "\tconfig-kernel\t\tCopy .config from lisa-qemu.\n"
	@echo -n "\tbuild-kernel\t\tBuild kernel.\n"
	@echo -n "\tpackage-kernel\t\tMake kernel debian package.\n"
	@echo -n "\tinstall-kernel\t\tInstall kernel Package (Specify KERNEL_PACKAGE=).\n"
	@echo -n "\tclean-kernel\t\tClean object files of kernel.\n"
	@echo -n "\n"
	@echo -n "Others\n"
	@echo -n "\tconfig[-target]\t\tConfig all or specified user program.\n"
	@echo -n "\tbuild-[-target]\t\tBuild all or specified user program.\n"
	@echo -n "\tclean-[-target]\t\tClean all or specified user program.\n"
	@echo -n "\tinstall-[-target]\tInstall all or specified user program.\n"
	@echo -n "\tunnstall-[-target]\tUninstall all or specified user program.\n"
	@echo -n "\treimage\t\t\tReimage with installed user programs.\n"

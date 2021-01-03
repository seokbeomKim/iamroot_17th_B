TOPDIR=$(shell realpath ../)
include ./Config.mk

SRC_DIR=$(shell pwd)/src

DEST_DIR=$(SYSTEM_ROOT_USR)/test

PREFIX_DIR=/usr
DATA_ROOT_DIR=/usr/share

CONFIG_OPT_LDFLAGS += -L$(SRC_DIR)/lib/.libs
CONFIG_OPT_LDFLAGS += -L$(SRC_DIR)/auparse/.libs


all: config build


config:
	cd $(SRC_DIR) && ./configure --host=$(CONFIG_OPT_HOST) \
		--build=$(CONFIG_OPT_BUILD) \
		--prefix=$(PREFIX_DIR) \
		--datadir=$(DATA_ROOT_DIR) \
		--disable-zos-remote \
		--without-python \
		--without-python3 \
		--with-debug \
		--with-aarch64 \
		--with-apparmor \
		CC=$(CC) \
		LD=$(LD) \
		CFLAGS="$(CONFIG_OPT_CFLAGS)" \
		LDFLAGS="$(CONFIG_OPT_LDFLAGS)"


build:
	$(MAKE) -C $(SRC_DIR)


install:
	mkdir -p $(DEST_DIR)
	sudo $(MAKE) -C $(SRC_DIR) DESTDIR=$(DEST_DIR) install


uninstall:
	sudo $(MAKE) -C $(SRC_DIR) DESTDIR=$(DEST_DIR) uninstall


clean:
	$(MAKE) -C $(SRC_DIR) clean

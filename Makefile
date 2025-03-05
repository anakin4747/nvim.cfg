PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
DESTDIR ?=

XDG_DATA_HOME ?= $(HOME)/.config
NVIM_CONFIG ?= $(XDG_DATA_HOME)/nvim

THIS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

install-v:
	mkdir -p $(DESTDIR)$(BINDIR)
	ln -sf $(THIS_DIR)/v $(DESTDIR)$(BINDIR)/v

install-cfg:
	-rm -r $(NVIM_CONFIG)
	ln -s $(THIS_DIR) $(NVIM_CONFIG)

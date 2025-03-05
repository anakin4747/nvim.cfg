PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
DESTDIR ?=

XDG_DATA_HOME ?= $(HOME)/.config
NVIM_CONFIG ?= $(XDG_DATA_HOME)/nvim

THIS_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

SCRIPTS := $(wildcard scripts/*)

.PHONY: install-scripts $(SCRIPTS)
install-scripts: $(SCRIPTS)

$(DESTDIR)$(BINDIR):
	mkdir -p $(DESTDIR)$(BINDIR)

$(SCRIPTS): $(DESTDIR)$(BINDIR)
	ln -sf $(THIS_DIR)/$@ $(DESTDIR)$(BINDIR)/$(notdir $@)

install-cfg:
	-rm -r $(NVIM_CONFIG)
	ln -s $(THIS_DIR) $(NVIM_CONFIG)


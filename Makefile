PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
DESTDIR ?=

XDG_DATA_HOME ?= $(HOME)/.config
NVIM_CONFIG ?= $(XDG_DATA_HOME)/nvim

THIS_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

.PHONY: help
help:
	@./util/list-make-targets $(MAKEFILE_LIST)

SCRIPTS := $(wildcard $(THIS_DIR)/scripts/*)

.PHONY: install-scripts $(SCRIPTS)
install-scripts: $(SCRIPTS) # Install scripts from ./scripts to $(DESTDIR)$(BINDIR)

.PHONY: uninstall-scripts
uninstall-scripts: # Uninstall scripts from $(DESTDIR)$(BINDIR)
	rm -r $(foreach s,$(SCRIPTS),$(DESTDIR)$(BINDIR)/$(notdir $s))

$(DESTDIR)$(BINDIR):
	mkdir -p $(DESTDIR)$(BINDIR)

$(SCRIPTS): $(DESTDIR)$(BINDIR)
	ln -sf $@ $(DESTDIR)$(BINDIR)/$(notdir $@)

install-cfg: # Install config
	-rm -r $(NVIM_CONFIG)
	ln -s $(THIS_DIR) $(NVIM_CONFIG)


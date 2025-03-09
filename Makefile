PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
DESTDIR ?=

XDG_DATA_HOME ?= $(HOME)/.config
NVIM_CONFIG ?= $(XDG_DATA_HOME)/nvim

THIS_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

.PHONY: help
help:
	@./util/list-make-targets $(MAKEFILE_LIST)

.PHONY: install
install: install-scripts install-cfg submodules # Install plugins, configuration and scripts

.PHONY: uninstall
uninstall: uninstall-scripts uninstall-cfg # Uninstall configuration and scripts

SUBMODULES := $(shell $(THIS_DIR)/util/gitmodules)

.PHONY: submodules
submodules: $(SUBMODULES) # Clone git submodules
$(SUBMODULES):
	git submodule update --init --recursive

SCRIPTS := $(wildcard $(THIS_DIR)/scripts/*)

.PHONY: install-scripts $(SCRIPTS)
install-scripts: $(SCRIPTS) # Install scripts from ./scripts to $(DESTDIR)$(BINDIR)

.PHONY: uninstall-scripts
uninstall-scripts: # Uninstall scripts from $(DESTDIR)$(BINDIR)
	-sudo rm -r $(foreach s,$(SCRIPTS),$(DESTDIR)$(BINDIR)/$(notdir $s))

$(DESTDIR)$(BINDIR):
	mkdir -p $(DESTDIR)$(BINDIR)

$(SCRIPTS): $(DESTDIR)$(BINDIR)
	sudo ln -sf $@ $(DESTDIR)$(BINDIR)/$(notdir $@)

.PHONY: install-cfg
install-cfg: uninstall-cfg # Install config
	ln -s $(THIS_DIR) $(NVIM_CONFIG)

.PHONY: uninstall-cfg
uninstall-cfg: # Uninstall config
	-rm -r $(NVIM_CONFIG)

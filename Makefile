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
install: install-nvim install-scripts install-cfg submodules # Install neovim, plugins, configuration and scripts

.PHONY: uninstall
uninstall: uninstall-scripts uninstall-cfg # Uninstall configuration and scripts

.PHONY: install-nvim
install-nvim: $(THIS_DIR)/nvim/build/bin/nvim # Build and install neovim
	sudo make CMAKE_INSTALL_PREFIX=$(PREFIX) -C nvim install

$(THIS_DIR)/nvim/build/bin/nvim:
	make CMAKE_BUILD_TYPE=Release
	ln -s $(THIS_DIR)/nvim/build/compile_commands.json $(THIS_DIR)/nvim/compile_commands.json

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

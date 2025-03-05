#!/bin/bash

PIPE_PATH="/tmp/nvim.pipe"

if pstree -s $$ | grep -q nvim; then
	# echo "in neovim"
	realpath $* | xargs -n1 nvim --server "$PIPE_PATH" --remote
else
	# echo "Not in neovim"
	if [ "$#" -eq "0" ]; then
		nvim +te --listen "$PIPE_PATH"
	else
		nvim $* --listen "$PIPE_PATH"
	fi
fi

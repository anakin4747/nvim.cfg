augroup hilight
	autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

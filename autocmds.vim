augroup hilight
    autocmd! hilight
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

augroup unfold
    autocmd! unfold
    autocmd BufRead * normal zR
augroup END

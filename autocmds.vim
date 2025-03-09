augroup hilight
    autocmd! hilight
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

augroup unfold
    autocmd! unfold
    autocmd BufRead * normal zR
augroup END

function! TrimTrailingWhitespace()
    let view = winsaveview()
    %substitute/\s\+$//e
    call winrestview(view)
endfunction

augroup trimtrailing
    autocmd! trimtrailing
    autocmd BufWritePre * call TrimTrailingWhitespace()
augroup END

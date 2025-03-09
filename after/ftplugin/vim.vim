setlocal keywordprg=:vert\ help

augroup removeHover
    autocmd! removeHover
    autocmd LspAttach * silent! nunmap <buffer> K
augroup END

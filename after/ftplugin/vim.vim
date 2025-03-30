setlocal keywordprg=:vert\ help

augroup removeHover
    autocmd! removeHover
    autocmd LspAttach *.vim silent! nunmap <buffer> K
augroup END

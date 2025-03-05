set scrollback=100000

augroup term
	autocmd TermOpen * setlocal modifiable nonumber norelativenumber
	autocmd BufEnter term://* setlocal modifiable nonumber norelativenumber
	autocmd BufEnter term://* execute 'cd' split(b:term_title, '//')[1]
	autocmd BufLeave term://* set scrolloff=9
augroup END

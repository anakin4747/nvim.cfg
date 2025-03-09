set scrollback=100000

augroup term
    autocmd! term
    autocmd TermOpen * setlocal modifiable nonumber norelativenumber
    autocmd BufEnter term://* setlocal modifiable nonumber norelativenumber
    autocmd BufEnter term://* execute 'silent! cd '.resolve('/proc/'.b:terminal_job_pid.'/cwd')
    autocmd BufLeave term://* set scrolloff=9
augroup END


function! ZZ()
    if &buftype == 'help'
        bdelete
    elseif &buftype == 'nowrite'
        bdelete
    elseif &buftype == 'nofile'
        bdelete
    elseif &buftype == 'prompt'
        bdelete!
    elseif &buftype == 'terminal'
        bwipeout! " Remove marks to buffer so that <C-o> won't work
        " Try to open the most recent terminal buffer
        silent! execute 'buf '.split(execute('filter /^term:/ buffers t'))[0]
    elseif &filetype == 'gitcommit'
        write
        quit
    else
        silent! write
        bdelete
        " Try to open the most recent non-terminal buffer
        silent! execute 'buf '.split(execute('filter! /^term:/ buffers t'))[0]
    endif
endfunction

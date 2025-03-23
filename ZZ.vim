" TODO: Figure out how to actually close a netrw buffer

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
    elseif &filetype == 'gitcommit'
        write
        bwipeout
    else
        silent! write
        bdelete
    endif
endfunction


function! s:GetTermBufList()
    return split(execute('filter /^term:/ buffers'), '\n')
endfunction

function! s:GetNonTermBufList()
    return split(execute('filter! /^term:/ buffers'), '\n')
endfunction

function! NextTermBuf()
    " If not in a term buffer just go to last term buffer
    if &buftype != 'terminal'
        "echom "NextTermBuf: Not in terminal"
        silent! execute 'buf '.split(execute('filter /^term:/ buffers t'))[0]
        return
    endif

    let bufs = s:GetTermBufList()

    " If there are no term buffers do nothing
    if len(bufs) == 0
        "echom "NextTermBuf: No terminal buffer: Do nothing"
        return
    endif

    let bufnr = bufnr('%')

    " If last buffer do nothing
    if bufnr == split(bufs[-1])[0]
        "echom "NextTermBuf: Last buffer: Do nothing"
        return
    endif

    let found = 0
    for buf in bufs
        if found
            "echom "NextTermBuf: Found buffer ".split(buf)[0]
            silent! execute 'buf '.split(buf)[0]
            break
        endif

        if split(buf)[0] == bufnr
            let found = 1
        endif
    endfor
endfunction

function! PrevTermBuf()
    " If not in a term buffer just go to last term buffer
    if &buftype != 'terminal'
        "echom "PrevTermBuf: Not in terminal"
        silent! execute 'buf '.split(execute('filter /^term:/ buffers t'))[0]
        return
    endif

    let bufs = s:GetTermBufList()

    " If there are no term buffers do nothing
    if len(bufs) == 0
        "echom "PrevTermBuf: No terminal buffer: Do nothing"
        return
    endif

    let bufnr = bufnr('%')

    " If first buffer do nothing
    if bufnr == split(bufs[0])[0]
        "echom "PrevTermBuf: First buffer: Do nothing"
        return
    endif

    let found = 0
    for buf in reverse(bufs)
        if found
            "echom "PrevTermBuf: Found buffer ".split(buf)[0]
            silent! execute 'buf '.split(buf)[0]
            break
        endif

        if split(buf)[0] == bufnr
            let found = 1
        endif
    endfor
endfunction

function! NextNonTermBuf()
    " If in a term buffer just go to last non-term buffer
    if &buftype == 'terminal'
        "echom "NextNonTermBuf: in terminal"
        silent! execute 'buf '.split(execute('filter! /^term:/ buffers t'))[0]
        return
    endif

    let bufs = s:GetNonTermBufList()

    " If there are no term buffers do nothing
    if len(bufs) == 0
        "echom "NextNonTermBuf: No non-term buffer: Do nothing"
        return
    endif

    let bufnr = bufnr('%')

    " If last buffer do nothing
    if bufnr == split(bufs[-1])[0]
        "echom "NextNonTermBuf: Last buffer: Do nothing"
        return
    endif

    let found = 0
    for buf in bufs
        if found
            "echom "NextNonTermBuf: Found buffer ".split(buf)[0]
            silent! execute 'buf '.split(buf)[0]
            break
        endif

        if split(buf)[0] == bufnr
            let found = 1
        endif
    endfor
endfunction

function! PrevNonTermBuf()
    " If in a term buffer just go to last non-term buffer
    if &buftype == 'terminal'
        "echom "PrevNonTermBuf: in terminal"
        silent! execute 'buf '.split(execute('filter! /^term:/ buffers t'))[0]
        return
    endif

    let bufs = s:GetNonTermBufList()

    " If there are no term buffers do nothing
    if len(bufs) == 0
        "echom "PrevNonTermBuf: No non-term buffer: Do nothing"
        return
    endif

    let bufnr = bufnr('%')

    " If last buffer do nothing
    if bufnr == split(bufs[0])[0]
        "echom "PrevNonTermBuf: First buffer: Do nothing"
        return
    endif

    let found = 0
    for buf in reverse(bufs)
        if found
            "echom "PrevNonTermBuf: Found buffer ".split(buf)[0]
            silent! execute 'buf '.split(buf)[0]
            break
        endif

        if split(buf)[0] == bufnr
            let found = 1
        endif
    endfor
endfunction


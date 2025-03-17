
function! GetNextBuf(current, bufs, ...)
    if exists("a:1") && a:1
        " Previous
        let end_buf = a:bufs[0]
    else
        " Next
        let end_buf = a:bufs[-1]
    endif

    if a:current == end_buf
        return a:current
    endif

    if exists("a:1") && a:1
        " Previous
        let buflist = reverse(copy(a:bufs))
    else
        " Next
        let buflist = a:bufs
    endif

    let found = 0

    for buf in buflist
        " Return the buf from the following iteration after finding
        if found
            return buf
        endif

        " If buf found set found to return on next iteration
        if buf == a:current
            let found = 1
        endif
    endfor

    " No buf was found
    return -1
endfunction

function! GetPrevBuf(current, bufs)
    return GetNextBuf(a:current, a:bufs, 1)
endfunction

function! TestGetBufsContainsBuf()
    " Returns -1 if current buffer not in bufs
    const bufs = [1, 2, 3]
    const cur = 4
    let ret = GetPrevBuf(cur, bufs)
    call assert_equal(-1, ret)

    let ret = GetNextBuf(cur, bufs)
    call assert_equal(-1, ret)
endfunction

function! TestGetPrevBuf()
    " Test that you can get the previous buffer
    const bufs = [1, 2]
    const cur = 2
    const ret = GetPrevBuf(cur, bufs)
    call assert_equal(1, ret)
endfunction

function! TestGetPrevBufStopsAtFirstBuf()
    " Test that GetPrevBuf stops at first buffer
    const bufs = [1, 2]
    const cur = 1
    const ret = GetPrevBuf(cur, bufs)
    call assert_equal(1, ret)
endfunction

function! TestGetNextBuf()
    " Test that you can get the previous buffer
    const bufs = [1, 2]
    const cur = 1
    const ret = GetNextBuf(cur, bufs)
    call assert_equal(2, ret)
endfunction

function! TestGetNextBufStopsAtLastBuf()
    " Test that GetPrevBuf stops at first buffer
    const bufs = [1, 2]
    const cur = 2
    const ret = GetNextBuf(cur, bufs)
    call assert_equal(2, ret)
endfunction

function! GetTermBufs(bufs)
    return map(filter(copy(a:bufs), 'v:val.name =~ "^term://"'), 'v:val.bufnr')
endfunction

function! GetNonTermBufs(bufs)
    return map(filter(copy(a:bufs), 'v:val.name !~ "^term://"'), 'v:val.bufnr')
endfunction

function! TestGetBufs()
    let bufs = [
    \   {'name': 'term://', 'bufnr': 1},
    \   {'name': '[Scratch]', 'bufnr': 2},
    \   {'name': 'term.vim', 'bufnr': 3},
    \]

    let ret = GetTermBufs(bufs)
    call assert_equal([1], ret)

    let ret = GetNonTermBufs(bufs)
    call assert_equal([2, 3], ret)
endfunction

function! NextTermBuf(...)
    " If not in a term buffer just go to last term buffer
    if &buftype != 'terminal'
        "echom "NextTermBuf: Not in terminal"
        execute 'buffer' split(execute('filter /^term:\/\// buffers t'))[0]
        return
    endif

    let bufs = GetTermBufs(getbufinfo({'buflisted': 1}))

    " If there are no term buffers do nothing
    if len(bufs) == 0
        "echom "NextTermBuf: No terminal buffer: Do nothing"
        return
    endif

    let next_buf = GetNextBuf(bufnr('%'), bufs, exists("a:1") && a:1)
    if next_buf > 0
        execute 'buffer' next_buf
    end
endfunction

function! PrevTermBuf()
    call NextTermBuf(1)
endfunction

function! NextNonTermBuf(...)
    " If in a term buffer just go to last non-term buffer
    if &buftype == 'terminal'
        "echom "NextNonTermBuf: in terminal"
        execute 'buffer' split(execute('filter! /^term:\/\// buffers t'))[0]
        return
    endif

    let bufs = GetNonTermBufs(getbufinfo({'buflisted': 1}))

    " If there are no term buffers do nothing
    if len(bufs) == 0
        "echom "NextTermBuf: No terminal buffer: Do nothing"
        return
    endif

    let next_buf = GetNextBuf(bufnr('%'), bufs, exists("a:1") && a:1)
    if next_buf > 0
        execute 'buffer' next_buf
    end
endfunction

function! PrevNonTermBuf()
    call NextNonTermBuf(1)
endfunction

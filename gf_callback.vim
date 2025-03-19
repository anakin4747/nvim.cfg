
" Highest priority matches first
let gf_patterns = [
\   '\v(cfile):(\d+):(\d+)',
\   '\v(cfile):(\d+)',
\]

function! GetPos(cfile, line, patterns)
    let pos = #{row: -1, col: -1}

    for pat in a:patterns

        let matches = matchlist(a:line, substitute(pat, "cfile", a:cfile, ""))

        " If no matches go to next pattern
        if len(matches) == 0
            continue
        endif

        if matches[1] == '' || matches[2] == ''
            break
        endif

        let pos.row = str2nr(matches[2])

        if matches[3] == ''
            break
        endif

        let pos.col = str2nr(matches[3])

        break

    endfor

    return pos

endfunction

function! TestGetPosRowCol()
    let line = "scripts/dtc/pylibfdt/libfdt_wrap.c:1262:1: note: declared here"
    let cfile = "scripts/dtc/pylibfdt/libfdt_wrap.c"
    let expected = #{row: 1262, col: 1}

    let actual = GetPos(cfile, line, g:gf_patterns)
    call assert_equal(expected, actual)
endfunction

function! TestGetPosRow()
    let line = "scripts/dtc/pylibfdt/libfdt_wrap.c:1262 note: declared here"
    let cfile = "scripts/dtc/pylibfdt/libfdt_wrap.c"
    let expected = #{row: 1262, col: -1}

    let actual = GetPos(cfile, line, g:gf_patterns)
    call assert_equal(expected, actual)
endfunction

" /bin/ls:12:12
"
" nvim:10:10

function! GotoFile()
    let cfile = expand('<cfile>')
    let line = getline('.')

    if !filereadable(cfile)
        echohl WarningMsg
        echomsg $"GotoFile: {cfile} is not readable"
        echohl None

        let file = findfile(cfile, "**")
        if file == ''
            return
        endif

        " Ignore hit enter prompt
        call feedkeys("\<CR>")

        execute "edit" file
    else
        execute "edit" cfile
    endif

    let pos = GetPos(cfile, line, g:gf_patterns)

    if pos.row != -1
        if pos.col == -1
            let pos.col = 0
        endif

        call cursor(pos.row, pos.col)
    endif

endfunction

nnoremap gf :call GotoFile()<CR>


command! RunTests call RunTests()

function! RunTests()

    let tests = substitute(execute("function /^Test"), "function ", "", "g")

    let v:errors = []

    for test in split(tests, "\n")
        execute "call ".test

        if !empty(v:errors)
            echohl WarningMsg
            echomsg $"FAIL: {test}: {v:errors}"
            echohl None
            let v:errors = []
        else
            echohl Title
            echomsg $"PASS: {test}"
            echohl None
        endif
    endfor

endfunction

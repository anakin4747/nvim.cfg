
vim.api.nvim_create_autocmd('CmdwinEnter', {
    pattern = ':',
    callback = function()
        vim.cmd [[
            setlocal nonumber
            setlocal norelativenumber cmdwinheight=1
        ]]
        local opts = { buffer = 0, noremap = true, silent = true }
        vim.keymap.set('n', '<esc>', '<C-c><C-c>', opts)
    end,
})

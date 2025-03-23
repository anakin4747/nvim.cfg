
vim.g.mapleader = ' '

local builtin = require('telescope.builtin')

local global_keymaps = {
    -- Navigate buffers
    { { 'n', 'i', 'x', 'v', 't' }, '<C-h>', '<C-\\><C-n>:call PrevTermBuf()<CR>',    'Previous terminal buffer' },
    { { 'n', 'i', 'x', 'v', 't' }, '<C-l>', '<C-\\><C-n>:call NextTermBuf()<CR>',    'Next terminal buffer' },
    { { 'n', 'v' },                '<S-h>', '<C-\\><C-n>:call PrevNonTermBuf()<CR>', 'Previous non-terminal buffer' },
    { { 'n', 'v' },                '<S-l>', '<C-\\><C-n>:call NextNonTermBuf()<CR>', 'Next non-terminal buffer' },

    -- Terminal
    { 't', '<S-h><S-h><S-h>', '<C-\\><C-n>:call PrevNonTermBuf()<CR>', 'Previous non-terminal buffer' },
    { 't', '<S-l><S-l><S-l>', '<C-\\><C-n>:call NextNonTermBuf()<CR>', 'Next non-terminal buffer' },
    { 't', '<esc><esc>', '<C-\\><C-n>',           'Double <esc> to exit terminal mode' },
    { 'n', '<leader>t',  '<C-\\><C-n>:terminal<cr>', 'Open a terminal' },
    { { 'n', 't', }, '<C-b>s', '<C-\\><C-n>:split +terminal<cr>i',      'Open a terminal below' },
    { { 'n', 't', }, '<C-b>v', '<C-\\><C-n>:vert split +terminal<cr>i', 'Open a terminal on the right' },
    { 't', '<C-w>', '<C-\\><C-n><C-w>', 'Terminal wincmds passthrough' },
    { 't', '<C-o>', '<C-\\><C-n><C-o>', 'Terminal escaped C-o' },

    -- { 't', '<C-y>', '<C-\\><C-n><C-y>', 'Terminal escape when scrolling with C-y or trackpad' },
    -- { 't', '<C-e>', '<C-\\><C-n><C-e>', 'Terminal escape when scrolling with C-e or trackpad' },

    -- Navigate windows
    { { 'n', 'i', 'v', 'x', 't', }, '<A-h>', '<C-\\><C-n><C-w>h', 'Move to left window' },
    { { 'n', 'i', 'v', 'x', 't', }, '<A-j>', '<C-\\><C-n><C-w>j', 'Move to lower window' },
    { { 'n', 'i', 'v', 'x', 't', }, '<A-k>', '<C-\\><C-n><C-w>k', 'Move to higher window' },
    { { 'n', 'i', 'v', 'x', 't', }, '<A-l>', '<C-\\><C-n><C-w>l', 'Move to right window' },

    -- Toggle crosshair
    { 'n', '<leader>ch', ':windo set invcuc | windo set invcul<CR>', 'Toggle crosshair' },

    -- Keep cursor postion with J
    { 'n', 'J', 'mzJ`z', 'Keeps cursor in place when using `J`' },

    -- Center after jumps
    { 'n', '<C-d>', '<C-d>zz', 'Center after <C-d>' },
    { 'n', '<C-u>', '<C-u>zz', 'Center after <C-u>' },
    { 'n', 'n', 'nzzzv', 'Center after next match' },
    { 'n', 'N', 'Nzzzv', 'Center after previous match' },

    -- Undotree
    { 'n', '<leader>ut', vim.cmd.UndotreeToggle, 'Toggle undotree' },

    -- Manpage undercursor
    { 'n', '<leader>K', function () vim.cmd('vert Man ' .. vim.fn.expand("<cword>")) end, 'Open Man Page for word undercursor' },

    { 'n', 'ZZ', ':call ZZ()<CR>', 'Call ZZ function' },

    -- Telescope
    { 'n', '<leader>au',    builtin.autocommands, 'Telescope :autocmds' },
    { 'n', '<leader>bu',    builtin.buffers,      'Telescope :buffers' },
    { 'n', '<leader>&',     builtin.vim_options,  'Telescope Vim options' },
    { 'n', '<leader><C-o>', builtin.resume,       'Reopen last telescope window' },
    { 'n', '<leader>fd',    builtin.fd,           'Telescope !fd' },
    { 'n', '<leader>ff',    builtin.find_files,   'Telescope find files' },
    { 'n', '<leader>fg',    builtin.live_grep,    'Telescope live grep' },
    { 'n', '<leader>gc',    builtin.git_bcommits, 'Telescope current buffer\'s git commits' },
    { 'n', '<leader>gf',    builtin.git_files,    'Telescope git files' },
    { 'n', '<leader>gl',    builtin.git_commits,  'Telescope current git commits' },
    { 'n', '<leader>gr',    builtin.grep_string,  'Telescope grep -r word under cursor' },
    { 'n', '<leader>gs',    builtin.git_status,   'Telescope !git status' },
    { 'n', '<leader>ht',    builtin.help_tags,    'Telescope help_tags' },
    { 'n', '<leader>km',    builtin.keymaps,      'Telescope keymaps' },
    { 'n', '<leader>m',     builtin.man_pages,    'Telescope man pages' },
    { 'n', '<leader>of',    builtin.oldfiles,     'Telescope :oldfiles' },
    { 'n', '<leader>rg',    builtin.registers,    'Telescope :registers' },
    { 'n', '<leader>ts',    builtin.treesitter,   'Telescope treesitter symbols' },

    -- Diagnostics
    { 'n', '<leader>e',  vim.diagnostic.open_float, 'Open diagnostics in floating window' },
    { 'n', '<leader>et', builtin.diagnostics,       'Open diagnostics in telescope window' },
    { 'n', '[d',         vim.diagnostic.goto_prev,  'Go to previous error' },
    { 'n', ']d',         vim.diagnostic.goto_next,  'Go to next error' },

    -- Testing
    { 'n', '<leader>v', ':RunTests<CR>', 'Run vim config tests' },

    -- Sourcing config
    { 'n', '<leader>s', ':source $MYVIMRC<CR>', 'Source vim config' },
}

for _, keymap in ipairs(global_keymaps) do
    local mode, lhs, rhs, desc = unpack(keymap)
    local opts = { noremap = true, silent = true, desc = desc }
    vim.keymap.set(mode, lhs, rhs, opts)
end

for i = 1, 9 do
    local opts = { noremap = true, silent = true, desc = "Move to " .. i .. " tabpage" }
    vim.keymap.set(
        { 'n', 't', 'v', 'i', 'x' },
        ('<M-%d>'):format(i),          -- Alt+[1-9]
        ('<C-\\><C-n>%dgt'):format(i), -- goto tab [1-9] (needs terminal escaping)
        opts
    )
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local b = vim.lsp.buf

        local buffer_keymaps = {
            -- { mode, lhs, rhs, description }
            { 'n', 'gD',         b.declaration,                 'LSP: Go to declaration' },
            { 'n', 'gd',         b.definition,                  'LSP: Go to definition' },
            { 'n', 'gr',         builtin.lsp_references,        'LSP: Get references in Telescope window' },
            { 'n', 'gt',         b.type_definition,             'LSP: Go to type definition' },
            { 'n', 'gtt',        builtin.lsp_type_definitions,  'LSP: Go to type definition' },
            { 'n', 'gi',         builtin.lsp_implementations,   'LSP: Go to implementation' },
            { 'n', 'K',          b.hover,                       'LSP: Hover documentation' },
            { 'n', '<C-k>',      b.signature_help,              'LSP: Signature help' },
            { 'n', '<leader>r',  b.rename,                      'LSP: Project global rename' },
            { 'n', '<leader>fs', builtin.lsp_document_symbols,  'LSP: document symbols in Telescope window' },
            { 'n', '<leader>ws', builtin.lsp_workspace_symbols, 'LSP: workspace symbols in Telescope window' },
            { 'n', '<leader>ic', builtin.lsp_incoming_calls,    'LSP: incoming calls in Telescope window' },
            { 'n', '<leader>oc', builtin.lsp_outgoing_calls,    'LSP: outgoing calls in Telescope window' },
        }

        for _, keymap in ipairs(buffer_keymaps) do
            local mode, lhs, rhs, desc = unpack(keymap)
            local opts = { buffer = ev.buf, noremap = true, silent = true, desc = desc }
            vim.keymap.set(mode, lhs, rhs, opts)
        end
    end,
})


local lspconfig = require('lspconfig')

local default_ls_configs = {
    'autotools_ls',
    'awk_ls',
    'bashls',
    'bitbake_ls',
    'clangd',
    'cmake',
    'csharp_ls',
    'dockerls',
    'ginko_ls',
    'gopls',
    'jsonls',
    -- 'ltex',
    'lua_ls',
    'pyright',
    'rust_analyzer',
    'ts_ls',
    'vimls',
}

-- setup default lsp configs
for _, def_ls_cfg_file in ipairs(default_ls_configs) do
    lspconfig[def_ls_cfg_file].setup({})
end

require('lazydev').setup()

vim.lsp.config.kconfig = {
    root_markers = { '.git' },
    cmd = { 'kconfig-language-server' },
    filetypes = { 'kconfig', 'c' },
}

vim.lsp.enable('kconfig')

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local b = vim.lsp.buf
        local builtin = require('telescope.builtin')

        local buffer_keymaps = {
            -- { mode, lhs, rhs, description }
            { 'n', 'gD',         b.declaration,                 'LSP: Go to declaration' },
            { 'n', 'gd',         b.definition,                  'LSP: Go to definition' },
            { 'n', 'gr',         builtin.lsp_references,        'LSP: Get references in Telescope window' },
            { 'n', 'gt',         b.type_definition,             'LSP: Go to type definition' },
            { 'n', 'gtt',        builtin.lsp_type_definitions,  'LSP: Go to type definition' },
            { 'n', 'gi',         builtin.lsp_implementations,   'LSP: Go to implementation' },
            { 'n', '<leader>r',  b.rename,                      'LSP: Project global rename' },
            { 'n', '<leader>fs', builtin.lsp_document_symbols,  'LSP: document symbols in Telescope window' },
            { 'n', '<leader>ws', builtin.lsp_workspace_symbols, 'LSP: workspace symbols in Telescope window' },
            { 'n', '<leader>ic', builtin.lsp_incoming_calls,    'LSP: incoming calls in Telescope window' },
            { 'n', '<leader>oc', builtin.lsp_outgoing_calls,    'LSP: outgoing calls in Telescope window' },

            { 'n', 'K',     function() b.hover({border = 'rounded'}) end,          'LSP: Hover documentation' },
            { 'n', '<C-k>', function() b.signature_help({border = 'rounded'}) end, 'LSP: Signature help' },
            { 'i', '<C-s>', function() b.signature_help({border = 'rounded'}) end, 'LSP: Signature help' },
        }

        for _, keymap in ipairs(buffer_keymaps) do
            local mode, lhs, rhs, desc = unpack(keymap)
            local opts = { buffer = ev.buf, noremap = true, silent = true, desc = desc }
            vim.keymap.set(mode, lhs, rhs, opts)
        end
    end,
})


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

do -- Add rounded borders to lsp popups

    local with = vim.lsp.with
    local handlers = vim.lsp.handlers

    handlers['textDocument/hover'] = with(handlers.hover, {
        border = 'rounded',
    })

    handlers['textDocument/signatureHelp'] = with(handlers.signature_help, {
        border = 'rounded',
    })
end

require('lazydev').setup()


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

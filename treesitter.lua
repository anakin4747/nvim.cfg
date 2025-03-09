
require('nvim-treesitter.configs').setup({
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        disable = { "vim" }
        --[[
            on the fence about this
            treesitter fails to highlight things like `%substitute///` nice
            but nvim fails to highlight lua code nicely
        --]]
    }
})

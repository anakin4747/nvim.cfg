set background=dark
set termguicolors
colorscheme gruvbox

lua << EOF
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' }) -- Enable opacity
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' }) -- Enable opacity
EOF

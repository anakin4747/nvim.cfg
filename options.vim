
" Line numbers
set number relativenumber

" Let lines run off screen but wrap if you type them
set nowrap textwidth=79

" Move anywhere
set virtualedit=all

" Always keep the cursor 9 chars from the border
set scrolloff=9 sidescrolloff=9

" Show evil whitespace
set list

" Tabbing
set shiftwidth=4 tabstop=4 smartindent expandtab

" Clean UI
set cmdheight=0 noshowcmd noruler noshowmode showtabline=0 laststatus=0

" Searching
set nohlsearch infercase incsearch smartcase

" New windows
set splitbelow splitright

" Use system clipboard
set clipboard=unnamedplus

" Faster completion
set updatetime=300

" Persistant undos
set undofile

" No swapfiles or backups
set noswapfile nobackup

" Ignore vim modelines in files (I don't want others setting my options)
set nomodeline

" No intro message
set shortmess+=I

set foldmethod=indent

" Display errors and breakpoints over numbers
set signcolumn=number

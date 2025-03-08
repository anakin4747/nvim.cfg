
runtime options.vim

runtime term.vim

runtime autocmds.vim
runtime color.vim

map <Space>of :browse oldfiles<Enter>
map ZZ :silent w! <Enter>: bd<Enter>

map <C-l> :bnext<Enter>
map <C-h> :bprev<Enter>
tmap <C-l> <C-\><C-n>:bnext<Enter>
tmap <C-h> <C-\><C-n>:bprev<Enter>

map <A-h> <C-w>h
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l
tmap <A-h> <C-\><C-n><C-w>h
tmap <A-j> <C-\><C-n><C-w>j
tmap <A-k> <C-\><C-n><C-w>k
tmap <A-l> <C-\><C-n><C-w>l

tmap <C-o> <C-\><C-n><C-o>
tmap <C-w> <C-\><C-n><C-w>
tmap <esc><esc> <C-\><C-n>


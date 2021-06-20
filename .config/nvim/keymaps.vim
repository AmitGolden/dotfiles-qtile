" Better nav for omnicomplete
"inoremap <expr> <c-j> ("\<C-n>")
"inoremap <expr> <c-k> ("\<C-p>")
" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" set leader key
let g:mapleader = "\<Space>"

" I hate escape more than anything else
"inoremap jk <Esc>
"inoremap kj <Esc>

" Easy CAPS
"inoremap <c-u> <ESC>viwUi
"nnoremap <c-u> viwU<Esc>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bn<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bp<CR>

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
"nnoremap <C-c> <Esc>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da

" don't yank on delete and change
nnoremap d "_d
xnoremap d "_d
xnoremap <leader>p "_dP
nnoremap <leader>d d
xnoremap <leader>d d

nnoremap D "_D
xnoremap D "_D
nnoremap <leader>D D
xnoremap <leader>D D

nnoremap C "_C
xnoremap C "_C
nnoremap <leader>C C
xnoremap <leader>C C

nnoremap c "_c
xnoremap c "_c
nnoremap <leader>c c
xnoremap <leader>c c

nnoremap x "_x
xnoremap x "_x

vnoremap p "_dP
vnoremap <leader>p p

" Esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

set hlsearch!
nnoremap <Leader>e :set hlsearch!<CR>

let g:camelcasemotion_key = '<leader>'

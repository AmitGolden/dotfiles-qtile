set nocompatible
filetype off
filetype plugin indent on

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
if !exists('g:vscode')
	" Themes
	Plug 'kaicataldo/material.vim'
	Plug 'itchyny/lightline.vim'
	Plug 'ryanoasis/vim-devicons'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	
	" Syntax
	Plug 'sheerun/vim-polyglot'
	
	" Completion
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	
	" File Nav
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'preservim/nerdtree'
	
	" Git
	Plug 'tpope/vim-fugitive'
	Plug 'junegunn/gv.vim'
endif

" Text Objects
Plug 'michaeljsmith/vim-indent-object'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'

" Movement
Plug 'bkad/CamelCaseMotion'
Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope'

" Actions
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

if !exists('g:vscode')
	source $HOME/.config/nvim/theme.vim
	source $HOME/.config/nvim/settings.vim
	source $HOME/.config/nvim/coc.vim
endif

if exists('g:vscode')
	highlight QuickScopePrimary guifg='#C3E88D' ctermfg=155 
	highlight QuickScopeSecondary guifg='#82AAFF' ctermfg=81 
	set smartcase
	source $HOME/.config/nvim/vscode.vim
endif


source $HOME/.config/nvim/keymaps.vim


hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE

" set nocursorline

hi LineNr guifg=grey
hi CursorLineNr guifg=white

" ================================
" Vim plugin configuration
" ================================

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle - required!
Plugin 'gmarik/Vundle.vim'

" My plugins
Plugin 'altercation/vim-colors-solarized'
Plugin 'elzr/vim-json'
Plugin 'guns/vim-clojure-static'
Plugin 'jeetsukumaran/vim-nefertiti'
Plugin 'junegunn/seoul256.vim'
Plugin 'Keithbsmiley/swift.vim'
Plugin 'mileszs/ack.vim'
Plugin 'raichoo/haskell-vim'
Plugin 'reedes/vim-colors-pencil'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/nginx.vim'
Plugin 'vim-scripts/peaksea'

call vundle#end()

" End Vim plugin configuration
""""""""""""""""""""""""""""""""""


""" Basic Display Options
set vb
set nowrap
set hidden

""" Backup Options
set backupdir=/tmp
set directory=/tmp
set nobackup
set nowritebackup

""" Automatically reload externally-edited files
set autoread

""" Tabbing Options
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set shiftround

""" Code Style Options
set showmatch
syntax on
filetype plugin indent on
set tags+=.tags

""" jj to enter normal mode from insert mode
inoremap jj <Esc>

""" Disable Mac keyboard navigation shortcuts
if has("gui_macvim")
    let macvim_skip_cmd_opt_movement=1
endif

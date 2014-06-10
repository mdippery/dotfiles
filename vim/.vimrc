""" Basic Display Options
set vb
set nowrap

""" Backup Options
set nobackup
set nowritebackup

""" Code Style Options
set showmatch
syntax on
filetype plugin indent on

""" Pathogen
execute pathogen#infect()

""" Tabbing Options
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set shiftround

""" Treat Gemfiles and Vagranfiles as Ruby
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby

""" Set line wrapping for HTML files
autocmd BufNewFile,BufRead *.html setlocal wrap linebreak

set nocompatible                                                            " Disable vi compatibility
filetype off                                                                " Vundle plugin management
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'JBakamovic/vim-project-manager'
Plugin 'JBakamovic/cxxd-vim'
Plugin 'JBakamovic/yaflandia'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'
call vundle#end()

filetype plugin indent on                                                   " Turn on the filetype plugin
syntax on                                                                   " Turn syntax highlighting on
set enc=utf-8                                                               " Set UTF-8 encoding
set fenc=utf-8
set termencoding=utf-8
set autoindent                                                              " Use indentation of previous line
set smartindent                                                             " Use intelligent indentation for C
set tabstop=4                                                               " Tab width is 4 spaces
set shiftwidth=4                                                            " Indent also with 4 spaces
set expandtab                                                               " Expand tabs to spaces
set nowrap                                                                  " Do not wrap lines
set hlsearch                                                                " Highlight all search results
set number                                                                  " Turn line numbers on
set showmatch                                                               " Highlight matching braces
set cul                                                                     " Highlight the current line
set wildmenu                                                                " Enable enhanced cmd-line completion
set nobackup                                                                " No backups, swap files, etc.
set noswapfile
set nowritebackup
set noequalalways                                                           " Do not maintain window-size ratio (when having multiple window splits I don't find it desirable)

if has("gui_running")                                                       " GUI Vim settings
    set guioptions=aeir                                                     " Minimize UI clutter. Enable vertical scrollbar.
    colorscheme yaflandia                                                   " Set the color scheme
    set lines=999 columns=999                                               " Run maximized
else                                                                        " Console Vim settings
    set t_Co=256                                                            " Set the color scheme
    if exists("+lines")                                                     " Run maximized
        set lines=50
    endif
    if exists("+columns")
        set columns=100
    endif
endif

" Airline
set laststatus=2
let g:airline_theme = 'alduin'                              " Select a theme
let g:airline_inactive_collapse = 0                         " Do not collapse the status line while having multiple windows
let g:airline#extensions#whitespace#enabled = 0             " Do not check for whitespaces
let g:airline#extensions#tabline#enabled = 1                " Display tab bar with buffers
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#branch#enabled = 1                 " Enable Git client integration
let g:airline#extensions#hunks#enabled = 1                  " Enable Git hunks integration

" NERDTree
let g:NERDTreeMouseMode = 2                                 " Single-click to expand the directory, double-click to open the file
let g:NERDTreeShowHidden = 1                                " Show hidden files


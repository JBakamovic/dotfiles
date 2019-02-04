"
" Base configuration
"
set nocompatible                                                            " Disable vi compatibility
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
if has("gui_running")                                                       " Tweak some settings when running in GUI
    set guioptions=aeir                                                     " Minimize UI clutter. Enable vertical scrollbar.
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9                       " Set the font
    set lines=999 columns=999                                               " Run maximized
endif
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor                                    " Use ag (the silver searcher) over grep if one exists on the system
endif

"
" Plugin selection
"
filetype off                                                                " Temporarily turn it off for Vundle setup
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
    Plugin 'pboettch/vim-cmake-syntax'
call vundle#end()
filetype plugin indent on                                                   " Turn it back on

"
" Set my favorite colorscheme
"
colorscheme yaflandia

"
" Key mappings
"
nnoremap    <M-Left>    <C-O>                                               |" Jump back and forward from cursor location
nnoremap    <M-Right>   <C-I>
nnoremap    <C-Down>    <C-e>                                               |" Scroll through buffers with arrows
nnoremap    <C-Up>      <C-y>
nnoremap    <C-c>       :bd<CR>                                             |" Close current buffer
nnoremap    <C-c>a      :%bd<CR>                                            |" Close all buffers
nnoremap    <C-c>c      :%bd<bar>e#<bar>bd#<CR>                             |" Close all buffers but the current one
nnoremap    <C-Tab>     :bnext<CR>                                          |" Cycle through buffers with TABs
nnoremap    <C-s-Tab>   :bprevious<CR>
nmap        <C-s>       <ESC>:w<CR>                                         |" Save
imap        <C-s>       <ESC>:w<CR>i
nnoremap    <C-a>       ggVG                                                |" Select all
vnoremap    <C-x>       "+x                                                 |" Cut
vnoremap    <C-c>       "+y                                                 |" Copy
map         <C-v>       "+gP                                                |" Paste (with some black magic from https://github.com/vim/vim/blob/master/runtime/mswin.vim)
cmap        <C-v>       <C-R>+
exe         'inoremap <script>  <C-v> <C-G>u' . paste#paste_cmd['i']
exe         'vnoremap <script>  <C-v> '       . paste#paste_cmd['v']
nnoremap    <Tab>       >>                                                  |" Make indents with TABs
nnoremap    <S-Tab>     <<
inoremap    <S-Tab>     <C-D>
vnoremap    <Tab>       >gv
vnoremap    <S-Tab>     <gv
nnoremap    <C-z>       u                                                   |" Undo
inoremap    <C-z>       <C-O>u
noremap     <C-R>       <C-R>                                               |" Redo
inoremap    <C-R>       <C-O><C-R>
nnoremap    <C-f>       :promptfind<CR>                                     |" Open find dialog
nnoremap    <C-h>       :promptrepl<CR>                                     |" Open find & replace dialog
nnoremap    <CR>        :let @/ = ""<CR><CR>                                |" Clear highlighted text occurences

"
" Make quickfix/location list occupy the full width
"
autocmd filetype qf wincmd J

"
" Airline
"
set laststatus=2
let g:airline_theme = 'alduin'                              " Select a theme
let g:airline_powerline_fonts = 1                           " Enable powerline fonts
let g:airline_inactive_collapse = 0                         " Do not collapse the status line while having multiple windows
let g:airline#extensions#whitespace#enabled = 0             " Do not check for whitespaces
let g:airline#extensions#tabline#enabled = 1                " Display tab bar with buffers
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#branch#enabled = 1                 " Enable Git client integration
let g:airline#extensions#hunks#enabled = 1                  " Enable Git hunks integration

"
" NERDTree
"
let g:NERDTreeMouseMode = 2                                 " Single-click to expand the directory, double-click to open the file
let g:NERDTreeShowHidden = 1                                " Show hidden files

"
" CtrlP
"
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'   " Use ag (the silver searcher) if one exists on the system. It is much faster.
endif
let g:ctrlp_use_caching = 1                                 " Enable CtrlP cache
"
" Auto-highlight words under the cursor (credits go to: https://stackoverflow.com/a/25233145)
"
function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
        exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
    else
        match none
    endif
endfunction
autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()

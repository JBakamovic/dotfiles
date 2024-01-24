"
" Base configuration
"
set nocompatible                                                            " Disable vi compatibility
filetype plugin indent on                                                   " Turn on the filetype plugin
syntax on                                                                   " Turn syntax highlighting on
set enc=utf-8                                                               " Set UTF-8 encoding
set fenc=utf-8
set termencoding=utf-8
set mousemodel=popup
set autoread                                                                " Auto-reload the file that has been changed from the outside
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
    set guifont=Source\ Code\ Pro\ Regular                                  " Set the font
    set lines=999 columns=999                                               " Run maximized
endif
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor                                    " Use ag (the silver searcher) over grep if one exists on the system
endif
set list                                                                    " Use listchars to show trailing spaces, tabs, eols etc.
set listchars+=trail:·
set listchars+=tab:»·
set listchars+=eol:¬

"
" Plugin selection
"
filetype off                                                                " Temporarily turn it off for Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'JBakamovic/vim-project-manager'
    Plugin 'JBakamovic/cxxd-vim'
    Plugin 'JBakamovic/yaflandia'
    Plugin 'cxxd-colors'
    Plugin 'scrooloose/nerdtree'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'tpope/vim-fugitive'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'pboettch/vim-cmake-syntax'
    Plugin 'vimwiki/vimwiki'
    Plugin 'shirk/vim-gas'
    Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plugin 'junegunn/fzf.vim'
call vundle#end()
filetype plugin indent on                                                   " Turn it back on

"
" Set my favorite colorscheme
"
colorscheme cxxd-slate

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
nnoremap    <C-CR>      :Ggrep <cword><CR>                                  |" Utilize git-grep to search for current word
nnoremap    <C-Space>   :call QuickFixWindowToggle()<CR>                    |" Toggle quick-fix window
nnoremap    <S-Space>   :call LocationListWindowToggle(winnr())<CR>         |" Toggle location-list window
nnoremap    <F2>        :NERDTreeToggle<CR>                                 |" Toggle NERDTree window
" FZF
nnoremap    <C-P>       :FzFiles<CR>
nnoremap    <C-M-P>     :FzGitFiles<CR>
nnoremap    <C-M-B>     :FzBuffers<CR>
nnoremap    <C-M-CR>    :FzRg <C-R><C-W><CR>
nnoremap    <C-M-Space> :FzBCommits<CR>

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
" fzf
"
let g:fzf_vim = {}
let g:fzf_vim.command_prefix = 'Fz'

"
" Magit
"
let g:magit_discard_untracked_do_delete = 1                 " Discard untracked files with DDD
let g:airline#extensions#vimagit#enabled = 1                " Enable airline support


"
" Check if quick-fix window is already opened
"
function! QuickFixWindowOpened()
    for winnr in range(1, winnr('$'))
        if getwinvar(winnr, '&syntax') == 'qf'
            return v:true
        endif
    endfor
    return v:false
endfunction

"
" Toggle quick-fix window
"
function! QuickFixWindowToggle()
  if QuickFixWindowOpened()
    cclose
  else
    execute "copen"
  endif
endfunction

"
" Check if location-list window is already opened for given window nr.
"
function! LocationListWindowOpened(win_nr)
    return get(getloclist(0, {'winid':0}), 'winid', 0) != 0
endfunction

"
" Open location-list window.
" Swallow E42 and E776 exceptions (No errors, No location list)
"
function! LocationListOpen()
    try
        execute "lopen"
    catch /:E553:/
    return v:false
    catch /:E\%(42\|776\):/
        return v:false
    catch /.*/
        echo v:exception
        return v:false
    endtry
    return v:true
endfunction

"
" Toggle location-list window
"
function! LocationListWindowToggle(win_nr)
  if LocationListWindowOpened(a:win_nr)
    lclose
  else
    call LocationListOpen()
  endif
endfunction

"
" Find and replace utility implemented through the means of find and sed.
"
function! FindAndReplaceImpl(dir, current, new)
    let cmd = "!find " . a:dir . " -type f -exec sed -i -e 's/" . a:current . "/" . a:new . "/g' {} \\\;"
    call execute(cmd)
endfunction

"
" Find and replace wrapper.
"
" It mostly exists because of the inability to unwrap <f-args> without having a function.
" Other than that, it serves the purpose of handling different use-cases one may find handy, such as:
"   1. In given directory, replace current word under cursor with some arbitrary text.
"   2. In given directory, replace current word under cursor with the same word but prefixed with
"      the given arbitrary text.
"   3. In given directory, replace current word under cursor with the same word but suffixed with
"      the given arbitrary text.
"   4. In given directory, replace arbitrary text with some other arbitrary text.
"
" See FindAndReplace* commands for proper usage.
function! FindAndReplace(curr_word, prefix, suffix, ...)
    if a:curr_word
        if a:prefix
            call FindAndReplaceImpl(a:1, expand('<cword>'), a:2 . expand('<cword>'))
        elseif a:suffix
            call FindAndReplaceImpl(a:1, expand('<cword>'), expand('<cword>') . a:2)
        else
            call FindAndReplaceImpl(a:1, expand('<cword>'), a:2)
        endif
    else
        call FindAndReplaceImpl(a:1, a:2, a:3)
    endif
endfunction

"
" Different actions that can be done with find-and-replace mechanism.
"
:command -nargs=+ -complete=dir FindAndReplace                  :call FindAndReplace(v:false, v:false, v:false, <f-args>)
:command -nargs=+ -complete=dir FindAndReplaceCurrWord          :call FindAndReplace(v:true, v:false, v:false, <f-args>)
:command -nargs=+ -complete=dir FindAndReplaceCurrWordWithPre   :call FindAndReplace(v:true, v:true, v:false, <f-args>)
:command -nargs=+ -complete=dir FindAndReplaceCurrWordWithSuf   :call FindAndReplace(v:true, v:false, v:true, <f-args>)

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

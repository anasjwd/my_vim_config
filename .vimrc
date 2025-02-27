" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set nu rnu

" Highlight cursor line underneath the cursor horizontally.
set cursorline
hi CursorLine ctermbg=black

" Set tab width to 4 columns.
set tabstop=4
set shiftwidth=4

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

"Set a column indicator at the 80th
set colorcolumn=80

"Enable mouse reporting
set mouse=a

"Open the vertical split window on the right side
set splitright

"set a scheme
set background=dark
colorscheme gruvbox

"set a plugin manager
execute pathogen#infect()

"map ctrl+h to ^
map <C-h> ^

"map ctrl+l to $
map <C-l> $

"set default shell to bash
set shell=/bin/bash

"open :explore with the current working directory
function! OpenTermInBufferDir()
    " Check if the current buffer has a valid file path
    if expand('%:p') != ''
       " Change to the directory of the current file
        execute 'lcd ' . expand('%:p:h')
    endif
    " Open a vertical terminal window
    execute 'vert term'
endfunction

" Map the function to Ctrl-t
nnoremap <C-t> :call OpenTermInBufferDir()<CR>

" Create a custom command for vertical split with the current working
" directory
command! -nargs=* -complete=customlist,BufferDirComplete VSHere call VSplit(<q-args>)

function! BufferDirComplete(ArgLead, CmdLine, CursorPos)
    let l:olddir = getcwd()
    execute 'lcd ' . expand('%:p:h')
    let l:files = glob(a:ArgLead.'*', 0, 1)
    execute 'lcd ' . l:olddir
    return l:files
endfunction

function! VSplit(args)
    let l:olddir = getcwd()
    execute 'lcd ' . expand('%:p:h')
    if empty(a:args)
        execute 'vertical split'
    else
        execute 'vertical split ' . a:args
    endif
    execute 'lcd ' . l:olddir
endfunction

cabbrev vs VSHere

"enabling mouse in vterm
set mouse=a
if has('mouse_sgr')
    set ttymouse=sgr
else
    set ttymouse=xterm2
endif

tmap <ScrollWheelUp> <C-w>N<ScrollWheelUp>
tmap <ScrollWheelDown> <C-w>N<ScrollWheelDown>

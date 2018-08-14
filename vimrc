
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Setting viminfo location
set viminfo+=n~/.vim/viminfo

" Colorscheme from https://github.com/tomasiser/vim-code-dark
set runtimepath^=~/.vim/bundle/vim-code-dark
colorscheme codedark

" Spaces & Tabs 
function! UseSpaces()
    set tabstop=8 " Size of a hard tabstop (ts).
    set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
    set expandtab " Always uses spaces instead of tab characters (et).
    set shiftwidth=4 " Size of an indentation (sw).
    set smarttab
    set autoindent " Inserts blanks on a <Tab> key (as per sw, ts and sts).
endfunction

function! UseTabs()
    set tabstop=4     " Size of a hard tabstop (ts).
    set shiftwidth=4  " Size of an indentation (sw).
    set noexpandtab   " Always uses tabs instead of space characters (noet).
    set autoindent    " Copy indent from current line when starting a new line (ai).
endfunction

call UseSpaces()

" UI Config
set number " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
set showmatch " highlight matching [{()}]

" Searching
set incsearch " search as characters are entered
set hlsearch " search as characters are entered

" turn off search highlight with \<space>
nnoremap <leader><space> :nohlsearch<CR>

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10

" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level

" Airline from https://github.com/vim-airline/vim-airline
set runtimepath^=~/.vim/bundle/vim-airline

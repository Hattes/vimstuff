" Based on https://github.com/sontek/dotfiles/
" ==========================================================
" Dependencies - Libraries/Applications outside of vim
" ==========================================================
" Pep8 - http://pypi.python.org/pypi/pepd
" Ack
" Rake & Ruby for command-t
" nose, django-nose

" ==========================================================
" Plugins included
" ==========================================================
" Pathogen
"     Better Management of VIM plugins
"
" GunDo
"     Visual Undo in vim with diff's to check the differences
"
" Command-T
"     Allows easy search and opening of files within a given path
"
" Snipmate
"     Configurable snippets to avoid re-typing common comands
"
" PyFlakes
"     Underlines and displays errors with Python on-the-fly
"
" Fugitive
"    Interface with git from vim
"
" Surround
"    Allows you to surround text with open/close tags
"
" Tabular
"    Auto-align stuff
" ==========================================================
" Shortcuts
" ==========================================================
set nocompatible              " Don't be compatible with vi

" To avoid 'Not an editor command' errors when exiting and saving while
" accidentally holding shift for too long :)
command! W :w
command! Wq :wq
command! Q :q
command! Qa :qa

" Commonly used php debug printout
command! PHPDebug :normal i error_log("1: ".var_export($temp, true)."\n", 3, '/tmp/ehansor.log');

" sudo write this
cmap W! w !sudo tee % >/dev/null

" ctrl-jklm  changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" and let's make these all work in insert mode too ( <C-O> makes next cmd
" happen as if in command mode )
imap <C-W> <C-O><C-W>

" Without this, enter key to open directory does not work
let g:NERDTreeDirArrows=0
let NERDTreeIgnore = ['\.pyc$']

" ==========================================================
" Pathogen - Allows us to organize our vim plugins
" ==========================================================
" Load pathogen with docs for all plugins
filetype off
call pathogen#incubate()
call pathogen#helptags()

" ==========================================================
" Basic Settings
" ==========================================================
syntax on                 " syntax highlighing
filetype on               " try to detect filetypes
"filetype plugin indent on " enable loading indent file for filetype
filetype plugin on        " enable all filetype plugins (hopefully including autocomplete in addition to indentation)
set number                " Display line numbers
set numberwidth=1         " using only 1 column (and 1 space) while possible
set background=dark       " We are using dark background in vim
set title                 " show title in console title bar. TODO: I fucked this one up I think, due to some plugin.
set wildmenu              " Menu completion in command mode on <Tab>
set wildmode=full         " <Tab> cycles between all matching choices.

" don't bell or blink
set noerrorbells
set vb t_vb=

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

set grepprg=ack         " replace the default grep program with ack.

""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window


""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
"set nowrap                  " don't wrap text
set linebreak               " don't wrap text in the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " and an indent level is 4 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes all spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
" Highlight last inserted text
nnoremap gV `[v`]

""" Folding
set foldenable              " use folding
set foldmethod=syntax       " fold by syntax. TODO: test this
set foldlevelstart=99       " have all folds open on opening buffer
set foldnestmax=10          " 10 nested fold max
let javaScript_fold=1       " JavaScript
let php_folding=1           " PHP
" Space opens/closes folds
nnoremap <space> za
"set foldlevel=99            " don't fold by default

" TODO: Figure out what this does
inoremap # #
inoremap # X#

" close preview window automatically when we move around. TODO: find out why
" this doesn't work.
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

"""" Messages, Info, Status
set ls=2                    " allways show status line
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
"set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}
"TODO: remove or fix this line above

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:¶,trail:~,precedes:<,extends:>
set list

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

set lazyredraw              " Don't redraw during e.g. macros.

"""" Display
"colorscheme desert
"colorscheme railscasts
let g:gruvbox_italic=0
colorscheme gruvbox
hi CursorLine term=bold cterm=bold guibg=Grey40

" Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" ==========================================================
" Javascript
" ==========================================================
autocmd BufRead *.js set makeprg=jslint\ %

" Use tab to scroll through autocomplete menus
"autocmd VimEnter * imap <expr> <Tab> pumvisible() ? "<C-N>" : "<Tab>"
"autocmd VimEnter * imap <expr> <S-Tab> pumvisible() ? "<C-P>" : "<S-Tab>"

let g:acp_completeoptPreview=1

" ===========================================================
" FileType specific changes
" ============================================================
" Mako/HTML
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2


nmap <F8> :TagbarToggle<CR>

" Python
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd FileType coffee setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" Load up virtualenv's vimrc if it exists
"if filereadable($VIRTUAL_ENV . '/.vimrc')
"    source $VIRTUAL_ENV/.vimrc
"endif

set colorcolumn=120
set wildmode=longest:full,full
set mouse=r
execute pathogen#infect()

" Automatically open NERDtree when opening vim without specifying a file
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

augroup filetypedetect
    au BufRead,BufNewFile *.test setfiletype php
    " associate *.test with php filetype
augroup END

set t_BE=

" Don't auto-open first result when using Ack
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" Leader stuff

" change the leader to be a comma instead of slash
let mapleader=","
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
" save session
nnoremap <leader>s :mksession<CR>
" recent files
nnoremap <leader>r :MRU<CR>
" Toggle the tasklist
map <leader>td <Plug>TaskList
let g:pep8_map='<leader>8'      " Run pep8. Maybe doesn't work due to missing plugin
" Reload Vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
" Open NerdTree
map <leader>n :NERDTreeToggle<CR>
" Set working directory to current directory
nnoremap <leader>. :lcd %:p:h<CR>
" Paste from clipboard
map <leader>p "+p
" Quit window on <leader>q
nnoremap <leader>q :q<CR>
" Stop highlighting search matches on <leader>space
nnoremap <silent> <leader><space> :nohlsearch<cr>
" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>


" In order to use find http://vim.wikia.com/wiki/Project_browsing_using_find
set path=$PWD/**

highlight Search guibg='Purple' guifg='NONE'

""" Plugins
" Pathogen Plugin
" https://github.com/tpope/vim-pathogen
call pathogen#infect()

" Prevent paredit from putting parens on a new line
"let g:paredit_electric_return = 0
" ...nvm... I kind of like that feature

""" Tab key
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

""" Searching
" When a bracket is inserted, briefly jump to the matching one
set showmatch
" While typing a search command, show where the pattern, as it was typed so far, matches
set showmatch
" While typing a search command, show where the pattern, as it was typed so far, matches.
set incsearch
" When there is a previous search pattern, highlight all its matches
set hlsearch
" Clear the search buffer when hitting return
function! MapCR()
    nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()
" Make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

""" Theme
syntax enable
set background=dark
"set background=light
colorscheme solarized
" Enable line numbering
set number
" Always show the status line
set laststatus=2
" Hide GUI toolbar and set font
if has("gui_running")
  set guioptions-=T
  set guifont=Menlo\ Bold:h12
endif
" Always show tab line
set showtabline=2

""" General Settings
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Vim can detect the type of file that is edited
filetype plugin indent on
" Make Vim behave in a more useful way in a non-Vi-compatible mode
set nocompatible
" Map leader keys
let maplocalleader = "_"
let mapleader = ","
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Show how long (visual) selection is
set showcmd
" Disable arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
" Try the following encodings from left to right when opening files
set fileencodings=utf-8,latin1

" Multipurpose tab key
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ }

" Mouse support
set mouse=a

" Misc key maps
map <leader>y "*y
map <leader>p "*p

" Visual white space
set list
set listchars=tab:>\ ,trail:.,extends:>

command W w

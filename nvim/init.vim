" I always mistype :w as :W
command W w

" Visual white space
set list
set listchars=tab:>\ ,trail:.,extends:>

""" Tab key
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

""" Searching
" When a bracket is inserted, briefly jump to the matching one
set showmatch
" While typing a search command, show where the pattern, as it was typed so far, matches.
set incsearch
" When there is a previous search pattern, highlight all its matches
set hlsearch
" Clear the search buffer when hitting escape twice (thrice in neovim)
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>
" Make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" Treat dashes as characters in a word
set iskeyword+=-

" Allow opening lots of tabs with `vim -p ...`
set tabpagemax=100

""" Line numbering
set number
highlight LineNr ctermfg=DarkGrey

""" base16.nvim
colorscheme solarized

""" vim-gitgutter
" Don't map any special keys for gitgutter
let g:gitgutter_map_keys = 0
" Use same background color for sign column as line number column
highlight! link SignColumn LineNr
" Update signs when files are read and saved
autocmd BufReadPost * GitGutter
autocmd BufWritePost * GitGutter
" Jump between hunks
nmap gh <Plug>(GitGutterNextHunk)<CR>zz
nmap gH <Plug>(GitGutterPrevHunk)<CR>zz

" Fix auto-indentation for YAML files, don't indent comments!
filetype plugin indent on
autocmd BufNewFile,BufReadPost * if &filetype == "yaml" | set expandtab shiftwidth=2 indentkeys-=0# | endif

" 2-space HTML
autocmd BufRead,BufNewFile *.htm,*.html setlocal tabstop=2 shiftwidth=2 softtabstop=2

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

" Fuzzy file opener on Ctrl+p
nnoremap <C-p> :FuzzyOpen<CR>

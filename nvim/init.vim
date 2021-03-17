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

" Allow opening lots of tabs with `vim -p ...`
set tabpagemax=100

set number

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

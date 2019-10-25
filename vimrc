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
" While typing a search command, show where the pattern, as it was typed so far, matches.
set incsearch
" When there is a previous search pattern, highlight all its matches
set hlsearch
" Clear the search buffer when hitting escape twice
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>
" Make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

""" Theme
syntax enable
"set background=dark
"set background=light
"colorscheme solarized
"colorscheme base16-solarized-light
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
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
"function! InsertTabWrapper()
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k'
"        return "\<tab>"
"    else
"        return "\<c-p>"
"    endif
"endfunction
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <s-tab> <c-n>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Completion

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" setup the supertab chaining for any filetype that has a provided |omnifunc|
" to first try that, then fall back to supertab's default, <c-p>, completion:
autocmd FileType *
  \ if &omnifunc != '' |
  \   call SuperTabChain(&omnifunc, "<c-p>") |
  \ endif

" https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE

"" change the 'completeopt' option so that Vim's popup menu doesn't select the
"" first completion item, but rather just inserts the longest common text of
"" all matches; and the menu will come up even if there's only one match. (The
"" longest setting is responsible for the former effect and the menuone is
"" responsible for the latter.)
set completeopt=longest,menuone

" Sets whether or not to pre-highlight the first match when completeopt has
" the popup menu enabled and the 'longest' option as well. When enabled, <tab>
" will kick off completion and pre-select the first entry in the popup menu,
" allowing you to simply hit <enter> to use it.
let g:SuperTabLongestHighlight = 1

"" Completion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Golang
""

" Cheat sheet:
"
" <leader>b     Build
" <leader>R     Build and run
" <leader>t     Test
" <leader>c     Test coverage
" <leader>d     Fuzzy search for declarations (ctrlp)
" <leader>r     Find referrers
" :A            :GoAlternate in current buffer
" :AV           :GoAlternate in vsplit
" :AS           :GoAlternate in split
" :AT           :GoAlternate in tabe
" vif           Select function code
" vaf           Select a (whole) function
" [[ and ]]     Navigate between functions
" gd            Go to definition (C-t takes you back)
" K             Show help text
" <tab>         Code completion (in insert mode)

" Vim has a setting called autowrite that writes the content of the file
" automatically if you call :make. vim-go also makes use of this setting. Open
" your .vimrc and add the following:
set autowrite

" You can add some shortcuts to make it easier to jump between errors in
" quickfix list:
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>q :cclose<CR>

" Dont use location lists
let g:go_list_type = "quickfix"

" I also use these shortcuts to build and run a Go program with <leader>b
" and <leader>r:
autocmd FileType go nmap <leader>R <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

"autocmd FileType go nmap <leader>b  <Plug>(go-build)
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" Automatically organize imports on save
let g:go_fmt_command = "goimports"

" Highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1

" Run vet, golint and errcheck on save
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "5s"

" Use ctrp to find declarations
autocmd FileType go nmap <leader>d :GoDeclsDir<CR>

" Find referrers too
autocmd FileType go nmap <leader>r :GoReferrers<CR>

" This will add new commands, called :A, :AV, :AS and :AT. Here :A works just
" like :GoAlternate, it replaces the current buffer with the alternate file.
" :AV will open a new vertical split with the alternate file. :AS will open
" the alternate file in a new split view and :AT in a new tab. These commands
" are very productive depending on how you use them, so I think it's useful to
" have them.
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" Type information in status bar
"autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
" Instead of default 800ms:
set updatetime=500

" vim-go can automatically highlight matching identifiers
let g:go_auto_sameids = 1

" This instructs deoplete to use omni completion for Go files.
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

""
"" Golang
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Allow opening lots of tabs with `vim -p ...`
set tabpagemax=100

" It seems to be popular to use 2 spaces indentation for YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" Same for JavaScript
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType jsx setlocal ts=2 sts=2 sw=2 expandtab

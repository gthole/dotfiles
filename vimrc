execute pathogen#infect()
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax enable
set ignorecase 
set incsearch
colorscheme molokai
set number

"Cursor colors"
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue

"Two character tab expansion by default"
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"Support mouse
set mouse=a

filetype plugin indent on

map <C-n> :NERDTree
map <C-;> <Esc>
let NERDTreeIgnore = ['\.pyc$', '\.git/', '.DS_Store$', '.class$', '.swp$']
let NERDTreeShowHidden = 1
set backupdir=$TMPDIR,.

let g:syntastic_check_on_open=1

" 80 character line
" Causes issues with ctrl-p opening over NERDTree
" set textwidth=80
" set colorcolumn=+1

"Easier pane navigation"
map <C-h> <C-W><A-Left>
map <C-j> <C-W><A-Down>
map <C-k> <C-W><A-Up>
map <C-l> <C-W><A-Right>

"CtrlP mappings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|virtualenv|venv)$',
  \ 'file': '\v\.(pyc|swp)$'
  \ }

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects
  " .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


autocmd StdinReadPre * let s:std_in=1

" Auto-open NERDTree
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Auto-trim trailing whitespace"
autocmd BufWritePre *.py,*.js,*.json,*.jl :%s/\s\+$//e

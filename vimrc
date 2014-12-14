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

filetype plugin indent on

map <C-n> :NERDTree
map <C-;> <Esc>
let NERDTreeIgnore = ['\.pyc$', '\.git/', '.DS_Store$', '.class$', '.swp$']
let NERDTreeShowHidden = 1
set backupdir=$TMPDIR,.

"Easier pane navigation"
map <C-h> <C-W><A-Left>
map <C-j> <C-W><A-Down>
map <C-k> <C-W><A-Up>
map <C-l> <C-W><A-Right>


"Ignore html_tidy issues"
let g:syntastic_html_tidy_ignore_errors = ["trimming empty <i>", "<a> escaping malformed URI reference"]

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Auto-trim trailing whitespace"
autocmd BufWritePre *.py,*.js,*.json,*.jl :%s/\s\+$//e

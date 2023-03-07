" execute pathogen#infect()
" call pathogen#infect()
" call pathogen#helptags()

"Basics"
syntax enable
set ignorecase
set incsearch
colorscheme mopkai
set number
filetype plugin indent on
set shell=/bin/bash

"Cursor colors"
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
hi Visual guifg=White guibg=LightBlue gui=none

highlight! link Visual CursorLine

inoremap <C-[> <Esc>

"Two character tab expansion by default"
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"Support mouse"
"set mouse=a"

vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

set backupdir=$TMPDIR
set directory=$TMPDIR
set wildignore+=.scrapy/

"80 character line; TODO: split this off into after/"
set colorcolumn=80

"Easier pane navigation"
map <C-h> <C-W><A-Left>
map <C-j> <C-W><A-Down>
map <C-k> <C-W><A-Up>
map <C-l> <C-W><A-Right>

"More natural split openings"
set splitbelow
set splitright

"JSON formatting
command Json execute "%!python3 -m json.tool"

"Syntastic settings"
let g:syntastic_shell = "/bin/zsh"
let g:syntastic_check_on_open=1
let g:syntastic_aggregate_errors = 1
"TODO: Figure out why jscs is so slow"
" let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_checkers = []
let g:syntastic_json_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['rubylint']
let g:syntastic_java_checkers = []
let g:typescript_indent_disable = 0

let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_ignore_missing_modules = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']

"NERDTree Settings"
" map <C-n> :NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.git/', '.DS_Store$', '.class$', '.swp$']
let NERDTreeShowHidden = 1
let g:NERDTreeRespectWildIgnore = 1

" ########################################################################
" Resize NERDTree if opening with only the NERDTree pane already present"
" ########################################################################

function! NerdTreeOpenFunc(action, line)
  "Check that the initial buffer is NERD tree and there are only two windows"
  if (winnr("$") ==# 2 && bufname(winbufnr(1)) == "NERD_tree_1")
    let size = g:NERDTreeWinSize
    call call('ctrlp#acceptfile', [a:action, a:line])
    "Resize the NERDTree window to it's original size"
    exec("silent wincmd h")
    exec("silent vertical resize ". size)
    exec("silent wincmd p")
  else
    call call('ctrlp#acceptfile', [a:action, a:line])
  endif
endfunction

" ########################################################################
"Auto commands"
" ########################################################################

"Auto-open NERDTree"
function! OpenNERDTree()
  NERDTree
  "Close the default empty pane opened at start"
  exec("wincmd l")
  exec("q")
endfunction
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | call call(function("OpenNERDTree"), []) | endif

" Open a file in same position we last left it
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

"Auto-trim trailing whitespace"
autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * :%s/\t/    /e

"Open images with iTerm
:autocmd BufEnter *.png,*.jpg,*gif exec ":silent ! open -g ".expand("%") | :bw

"Don't expand tabs in make files"
autocmd FileType make setlocal noexpandtab

hi Visual ctermfg=Yellow ctermbg=NONE cterm=bold

execute pathogen#infect()
call pathogen#infect()
call pathogen#helptags()

"Basics"
syntax enable
set ignorecase
set incsearch
colorscheme molokai
set number
filetype plugin indent on

"Cursor colors"
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue

"Two character tab expansion by default"
set tabstop=2
set shiftwidth=2
set softtabstop=2
set formatoptions-=t
set expandtab

"Support mouse"
set mouse=a

"NERDTree Settings"
map <C-n> :NERDTree
map <C-;> <Esc>
let NERDTreeIgnore = ['\.pyc$', '\.git/', '.DS_Store$', '.class$', '.swp$']
let NERDTreeShowHidden = 1
set backupdir=$TMPDIR,.

"Syntastic settings"
let g:syntastic_check_on_open=1
let g:syntastic_aggregate_errors = 1
"TODO: Figure out why jscs is so slow"
let g:syntastic_javascript_checkers = ['jshint']

"80 character line; TODO: split this off into after/"
set textwidth=80
set colorcolumn=+1

"Easier pane navigation"
map <C-h> <C-W><A-Left>
map <C-j> <C-W><A-Down>
map <C-k> <C-W><A-Up>
map <C-l> <C-W><A-Right>

"More natural split openings"
set splitbelow
set splitright

"CtrlP mappings"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|virtualenv|venv)$',
  \ 'file': '\v\.(pyc|swp)$'
  \ }

"Resize NERDTree if opening with only the NERDTree pane already present"
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
let g:ctrlp_open_func = { 'files': 'NerdTreeOpenFunc' }

"User ag 'the silver searcher' for ctrl-p.  Fast and respects .gitignore"
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"Auto commands"
"Auto-open NERDTree"
function! OpenNERDTree()
  NERDTree
  "Close the default empty pane opened at start"
  exec("wincmd l")
  exec("q")
endfunction
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | call call(function("OpenNERDTree"), []) | endif

"Auto-trim trailing whitespace"
autocmd BufWritePre *.py,*.js,*.json,*.jl :%s/\s\+$//e

execute pathogen#infect()
call pathogen#infect()
call pathogen#helptags()

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

"NERDTree Settings"
" map <C-n> :NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.git/', '.DS_Store$', '.class$', '.swp$']
let NERDTreeShowHidden = 1
set backupdir=$TMPDIR
set directory=$TMPDIR
set wildignore+=.scrapy/
let g:NERDTreeRespectWildIgnore = 1

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

" au BufNewFile,BufRead *.ejs set filetype=html

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
command Json execute "%!python -m json.tool"

"CtrlP mappings"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|virtualenv|venv)$',
  \ 'file': '\v\.(pyc|swp)$'
  \ }

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
let g:ctrlp_open_func = { 'files': 'NerdTreeOpenFunc' }

" ########################################################################
" User ag 'the silver searcher' for ctrl-p.  Fast and respects .gitignore"
" ########################################################################

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" ########################################################################
" Multipurpose Tab Key (thanks Gary Bernhardt)
" Tab indents at the start of a line, but is autocomplete otherwise
" ########################################################################
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "    "
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

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

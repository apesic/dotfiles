filetype off
filetype plugin indent on

set nocompatible

call pathogen#infect()
call pathogen#helptags()

set t_Co=256

colorscheme hybrid_material
set background=dark
let g:enable_bold_font = 1
syntax on

set hidden
set modelines=0
set mouse=a
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set undofile
set showcmd
set wildmenu
set wildmode=list:longest
set visualbell
set noerrorbells
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set clipboard+=unnamed              " Use system clipboard
"set go+=a                           " Visual selection automatically copied to clipboard
set autochdir                       " Autoupdate current dir
set backup                          " Automatic backup
set wrap
set formatoptions=qrn1
set cul
au FocusLost * :wa
set number
set numberwidth=4
set autoread

" Leaving foldmethod=syntax on all the time causes horrible slowdowns for some syntaxes in gvim.
set foldmethod=manual
set foldlevel=99

" Remaps
nnoremap <Space> <nop>
let mapleader="\<Space>"
nnoremap ; :
"inoremap jj <ESC>
"nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"map <leader>pp :setlocal paste!<cr>
"map <leader>po :setlocal nopaste!<cr>
nmap > >>
nmap < <<
map <Tab> %
"map <leader>z :bp<cr>
"map <leader>x :bn<cr>
map Y y$
noremap K <Nop>

" Better searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader>, :noh<cr>

" Textmate-style invisible char markers
"set list
"set listchars=tab:\ \ ,eol:¬

" Show extra whitespace
hi ExtraWhitespace guibg=#CCCCCC
hi ExtraWhitespace ctermbg=7
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Ensure the temp dirs exist
if !isdirectory($HOME . "/.vim/tmp")
  call system("mkdir -p ~/.vim/tmp/swap")
  call system("mkdir -p ~/.vim/tmp/backup")
  call system("mkdir -p ~/.vim/tmp/undo")
endif

" Change where we store swap/undo files
set dir=~/.vim/tmp/swap//
set backupdir=~/.vim/tmp/backup//
set undodir=~/.vim/tmp/undo/

set noswapfile

" Don't back up temp files
set backupskip=/tmp/*,/private/tmp/*

" Don't save help pages in sessions
set sessionoptions-=help
" Don't save hidden buffers -- only save the visible ones.
set sessionoptions-=buffers
autocmd BufWritePre * :%s/\s\+$//e

" Text wrapping
set colorcolumn=110
set textwidth=110
let &wrapmargin= &textwidth
set formatoptions=croql " Now it shouldn't hard-wrap long lines as you're typing (annoying), but you can gq
                        " as expected.

if &term =~ '^xterm'
    let &t_SI .= "\<Esc>[6 q"
    let &t_EI .= "\<Esc>[2 q"
    " 1 or 0 -> blinking block
    " 3 -> blinking underscore
    " Recent versions of xterm (282 or above) also support
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
endif

"Ctrl-P
"set runtimepath^=~/.vim/bundle/ctrlp.vim
"let g:ctrlp_user_command = 'ag %s -l --nocolor --files-with-matches --hidden -g "" -p ~/.agignore'
"let g:ctrlp_switch_buffer = 0
"nnoremap <C-f> :CtrlPBuffer<cr>

"Airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_theme = 'hybrid'
set noshowmode

autocmd BufNewFile,BufReadPost *.md set filetype=markdown "Auto detect markdown filetype
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

"Expand-region
"vmap v <Plug>(expand_region_expand)
"vmap <C-v> <Plug>(expand_region_shrink)

"" -------------------------------------- EasyMotion Settings -------------------------------------------
"let g:EasyMotion_do_mapping = 0 " Disable default mappings
"map <Space> <Plug>(easymotion-prefix)
" Bi-directional find motion
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
"map <Space>t <Plug>(easymotion-s2)

" Turn on case insensitive feature
"let g:EasyMotion_smartcase = 1

" HJKL motions: Line motions
"map <Space>l <Plug>(easymotion-lineanywhere)
"map <Space>j <Plug>(easymotion-j)
"map <Space>k <Plug>(easymotion-k)
"map <Space>h <Plug>(easymotion-linebackward)
"let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)

"let g:EasyMotion_use_upper = 1
"let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'

"
"" ------------------------------------ Language-specific Settings ---------------------------------------
" Nice ruby settings
let ruby_space_settings = 1

" Markdown settings
augroup markdown
  au!
  au FileType markdown setlocal comments=b:*,b:-,b:+,n:>h
augroup END

" Clojure settings
let g:clojure_align_multiline_strings = 0
let g:clojure_fuzzy_indent = 1
let g:clojure_fuzzy_indent_patterns = "with.*,def.*,let.*,send.*"
let g:clojure_fuzzy_indent_patterns .= ",GET,POST,PUT,PATCH,DELETE,context"   " Compojure
let g:clojure_fuzzy_indent_patterns .= ",clone-for"                           " Enlive
let g:clojure_fuzzy_indent_patterns .= ",select,insert,update,delete,with.*"  " Korma
let g:clojure_fuzzy_indent_patterns .= ",fact,facts"                          " Midje
let g:clojure_fuzzy_indent_patterns .= ",up,down"                             " Lobos
let g:clojure_fuzzy_indent_patterns .= ",entity"                              " Custom
let g:clojure_fuzzy_indent_patterns .= ",check"                               " Custom

let g:syntastic_javascript_checkers = ['eslint']


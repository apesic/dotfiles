"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
"source ~/.vim/.vimrc

set background=dark
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
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes
set wrap
set formatoptions=qrn1
set cul
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

runtime! partials/*.vim

set noswapfile
" Don't back up temp files
set backupskip=/tmp/*,/private/tmp/*

" Don't save help pages in sessions
set sessionoptions-=help
" Don't save hidden buffers -- only save the visible ones.
set sessionoptions-=buffers
autocmd BufWritePre * :%s/\s\+$//e
" Text wrapping
set colorcolumn=80
set textwidth=80
let &wrapmargin= &textwidth
set formatoptions=croql " Now it shouldn't hard-wrap long lines as you're typing (annoying), but you can gq
                        " as expected.

colorscheme onedark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


call plug#begin('~/.config/nvim/plugged')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'mbbill/undotree'
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-fugitive'
  Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
  Plug 'godlygeek/tabular'
  Plug 'elzr/vim-json', { 'for': ['json', 'markdown'] }

  Plug 'tpope/vim-surround'

  Plug 'sheerun/vim-polyglot'

  Plug 'tmux-plugins/vim-tmux-focus-events'

  " .tmux.conf syntax highlighting and setting check
  Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }

  Plug 'jeffkreeftmeijer/vim-numbertoggle'

  Plug 'machakann/vim-highlightedyank'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'neoclide/coc.nvim', { 'do': 'yarn install' }
  Plug 'Olical/conjure', { 'tag': 'v2.1.0', 'do': 'bin/compile' }
  Plug 'vimwiki/vimwiki'
  Plug 'bling/vim-airline'
  Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
  Plug 'joshdick/onedark.vim'
  Plug 'ferrine/md-img-paste.vim'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
  Plug 'tpope/vim-commentary'
call plug#end()


"""""""""""""""""""""""""fzf settings""""""""""""""""""""""""""
nnoremap <C-f> :Files<CR>
nnoremap <silent><Leader>b :Buffers<CR>
nnoremap <silent><Leader>t :BTags<CR>
nnoremap <silent><Leader>m :History<CR>
nnoremap <silent><Leader>g :GFiles?<CR>

" Hide status line when open fzf window
augroup fzf_hide_statusline
	autocmd!
	autocmd! FileType fzf
	autocmd  FileType fzf set laststatus=0 noshowmode noruler
				\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

"""""""""""""""""""""""""fzf.vim settings""""""""""""""""""
" Customize fzf colors to match your color scheme
let g:fzf_colors =
			\ { 'fg':      ['fg', 'Normal'],
			\ 'bg':      ['bg', 'Normal'],
			\ 'hl':      ['fg', 'Comment'],
			\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
			\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
			\ 'hl+':     ['fg', 'Statement'],
			\ 'info':    ['fg', 'PreProc'],
			\ 'border':  ['fg', 'Ignore'],
			\ 'prompt':  ['fg', 'Conditional'],
			\ 'pointer': ['fg', 'Exception'],
			\ 'marker':  ['fg', 'Keyword'],
			\ 'spinner': ['fg', 'Label'],
			\ 'header':  ['fg', 'Comment'] }



let g:vimwiki_list = [{
  \ 'path': '~/Sync/notes',
  \ 'syntax': 'markdown', 'ext': '.md',
  \ 'automatic_nested_syntaxes': 1,
  \ 'auto_diary_index': 1,
  \ 'auto_generate_links': 1,
  \ 'auto_tags': 1,
  \ 'auto_generate_tags': 1,
 \}]

let g:vimwiki_auto_header = 1
let g:vimwiki_global_ext = 0

let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PopupShowStatusline = 0
let g:Lf_PopupPreviewPosition = 'bottom'
let g:Lf_PopupPosition = [5, 0]
"let g:Lf_AutoResize = 1
"let g:Lf_CommandMap = {'<C-N>': ['Down'], '<C-P>': ['Up']}
let g:Lf_PreviewCode = 1
let g:Lf_PreviewResult = {
  \ 'File': 1,
  \ 'Buffer': 1,
  \ 'Mru': 0,
  \ 'Tag': 0,
  \ 'BufTag': 1,
  \ 'Function': 1,
  \ 'Line': 0,
  \ 'Colorscheme': 0,
  \ 'Rg': 0,
  \ 'Gtags': 0
  \}

let g:mdip_imgdir_absolute = '/Users/apesic/Sync/notes/assets'

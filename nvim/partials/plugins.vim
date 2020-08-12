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

  Plug 'yuttie/comfortable-motion.vim'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'neoclide/coc.nvim', { 'do': 'yarn install' }
  Plug 'Olical/conjure', { 'tag': 'v2.1.0', 'do': 'bin/compile' }
  Plug 'vimwiki/vimwiki'
  Plug 'bling/vim-airline'

call plug#end()


"""""""""""""""""""""""""fzf settings""""""""""""""""""""""""""
nnoremap <silent><C-f> :Files<CR>
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

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

let $FZF_DEFAULT_OPTS = '--layout=reverse'
" Floating windows only works for latest nvim version.
" Use floating window to open the fzf search window
let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

function! OpenFloatingWin()

	let height = &lines - 3
	let width = float2nr(&columns - (&columns * 2 / 10))
	let col = float2nr((&columns - width) / 2)

	" Set up the attribute of floating window
	let opts = {
				\ 'relative': 'editor',
				\ 'row': height * 0.3,
				\ 'col': col + 20,
				\ 'width': width * 2 / 3,
				\ 'height': height / 2
				\ }

	let buf = nvim_create_buf(v:false, v:true)
	let win = nvim_open_win(buf, v:true, opts)

	" Floating window highlight setting
	call setwinvar(win, '&winhl', 'Normal:Pmenu')

	setlocal
				\ buftype=nofile
				\ nobuflisted
				\ bufhidden=hide
				\ nonumber
				\ norelativenumber
				\ signcolumn=no
endfunction
"}}


let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

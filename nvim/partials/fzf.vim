"let g:fzf_layout = { 'window': 'call FloatingFZF()' }

nnoremap <silent><C-p> :Files<CR>
nnoremap <silent><Leader>b :Buffers<CR>
nnoremap <silent><Leader>t :BTags<CR>
nnoremap <silent><Leader>m :History<CR>
nnoremap <silent><Leader>g :GFiles?<CR>

function! s:goto_def(lines) abort
  silent! exe 'e +BTags '.a:lines[0]
  call timer_start(10, {-> execute('startinsert') })
endfunction

function! s:goto_line(lines) abort
  silent! exe 'e '.a:lines[0]
  call timer_start(10, {-> feedkeys(':') })
endfunction

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ '@': function('s:goto_def'),
  \ ':': function('s:goto_line')
  \  }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let opts = {
        \ 'relative': 'editor',
        \ 'row': &lines / 4,
        \ 'col': float2nr(round((&columns - (&columns / 1.2)) / 2)),
        \ 'width': float2nr(&columns / 1.2),
        \ 'height': &lines / 2
        \ }

  let win = nvim_open_win(buf, v:true, opts)
  call nvim_win_set_option(win, 'number', v:false)
  call nvim_win_set_option(win, 'relativenumber', v:false)
endfunction

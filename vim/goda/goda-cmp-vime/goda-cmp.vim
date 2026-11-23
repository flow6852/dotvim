" hook_add {{{
inoremap <M-s> <Plug>(goda-skk-toggle)
cnoremap <M-s> <Plug>(goda-skk-toggle)
tnoremap <M-s> <Plug>(goda-skk-toggle)
" }}}

" hook_source {{{
function! s:changeSource2Skk() abort
    if !exists('s:bef_buffer')
        let s:bef_buffer = goda_cmp#get_current()
    endif

    let s:skkSources = ['skkokuri', 'skk']
    
    call goda_cmp#set_buffer({
        \ 'sources': s:skkSources,
        \ 'ui': 'pum',
        \ 'sourceOptions': {
        \   'skk': {
        \     'mark': '[skk]',
        \     'matchers': [],
        \     'sorters': [],
        \     'minAutoCompleteLength': 2,
        \   },
        \   'skkokuri': {
        \     'mark': '[skkokuri]',
        \     'matchers': [],
        \     'sorters': [],
        \     'minAutoCompleteLength': 2,
        \   },
        \ }})
    call pum#set_option('auto_select', v:false)
    echo s:skkSources

    inoremap <expr><CR> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
endfunction

function! s:changeSkk2Source() abort
    " Restore sources
    if exists('s:bef_buffer')
        call goda_cmp#set_buffer(s:bef_buffer)
        unlet s:bef_buffer
    else
        call goda_cmp#set_buffer(goda_cmp#get_current())
    endif
    call pum#set_option('auto_select', v:false)
    inoremap <silent><expr><CR> '<CR>'
endfunction

augroup skk-initialize-pre
  autocmd!
  autocmd User goda-skk-enable-pre call s:changeSource2Skk()
  autocmd User goda-skk-disable-pre call s:changeSkk2Source()
augroup END 

inoremap <expr><M-b> '<Cmd>call RotateCmpSources()<CR>'
cnoremap <expr><M-b> '<Cmd>call RotateCmpSources()<CR>'

call goda_cmp#enable()
call goda_cmp#enable_cmdline()
" }}}

imap <C-t> <Plug>(skkeleton-toggle)
cmap <C-t> <Plug>(skkeleton-toggle)
tmap <C-\><C-t> <Plug>(skkeleton-toggle)

" let g:sources = insert(g:sources, 'skkeleton', 0)
" call ddc#custom#patch_global('sources', g:sources)
" call ddc#custom#patch_global(
"     \ 'sourceOptions', {
"     \   'skkeleton': {
"     \     'mark': '[skkeleton]',
"     \     'matchers': ['skkeleton'],
"     \     'sorters': [],
"     \     'minAutoCompleteLength': 2,
"     \   },
"     \ })
" call skkeleton#config({'completionRankFile': '~/.skkeleton/rank.json'})

function! s:skkeleton_init() abort
    call skkeleton#config({
      \ 'eggLikeNewline': v:true, 
      \ 'globalDictionaries': ['/usr/share/skk/SKK-JISYO.L','/usr/share/skk/SKK-JISYO.S','/usr/share/skk/SKK-JISYO.M' ,'/usr/share/skk/SKK-JISYO.ML' ],
      \ })

    call add(g:skkeleton#mapped_keys, '<S-l>')
    call skkeleton#register_keymap('input', '<S-l>', v:false)

    call skkeleton#register_kanatable('rom', {
      \ 'la' : ['ぁ'],
      \ 'li' : ['ぃ'],
      \ 'lu' : ['ぅ'],
      \ 'le' : ['ぇ'],
      \ 'lo' : ['ぉ'],
      \ 'ltu' : ['っ'],
      \ "z\<Space>": ["\u3000", ''],
      \ })

    call add(g:skkeleton#mapped_keys, 'kt')
    call skkeleton#register_keymap('input', 'kt', 'katakana')
endfunction

function! s:changeSource2Skk() abort
    if !exists('b:bef_buffer')
        let b:bef_buffer = ddc#custom#get_current()
    endif

    let s:skkSource = ['skkeleton', 'around', 'rg']
    
    call ddc#custom#set_buffer({
        \ 'sources': s:skkSource,
        \ 'sourceOptions': {
        \   'skkeleton': {
        \     'mark': '[skkeleton]',
        \     'matchers': ['skkeleton'],
        \     'sorters': [],
        \     'minAutoCompleteLength': 1,
        \     'isVolatile': v:true
        \   },
        \ }})
    call skkeleton#config({'completionRankFile': '~/.skkeleton/rank.json'})
    call pum#set_option('auto_select', v:true)
endfunction

function! s:changeSkk2Source() abort
    " Restore sources
    if exists('b:bef_buffer')
        call ddc#custom#set_buffer(b:bef_buffer)
        unlet b:bef_buffer
        call ddc#disable_cmdline_completion()
    else
        call ddc#custom#set_buffer(ddc#custom#get_current())
    endif
    call pum#set_option('auto_select', v:false)
endfunction

augroup skkeleton_callbacks
  autocmd!
  autocmd User skkeleton-initialize-pre call s:skkeleton_init()
  autocmd User skkeleton-enable-pre call s:changeSource2Skk()
  autocmd User skkeleton-disable-pre call s:changeSkk2Source()
augroup END

" hook_source {{{
inoremap <M-s> <Plug>(skkeleton-toggle)
cnoremap <M-s> <Plug>(skkeleton-toggle)
tnoremap <M-s> <Plug>(skkeleton-toggle)

function! s:skkeleton_init() abort
     call skkeleton#config({
       \ 'eggLikeNewline': v:false,
       \ 'globalDictionaries': has('unix') ? ['/usr/share/skk/SKK-JISYO.L','/usr/share/skk/SKK-JISYO.S','/usr/share/skk/SKK-JISYO.M' ,'/usr/share/skk/SKK-JISYO.ML' ] 
       \                                   : ['~/.skk/SKK-JISYO.L','~/.skk/SKK-JISYO.S','~/.skk/SKK-JISYO.M' ,'~/.skk/SKK-JISYO.ML' ],
       \ 'completionRankFile': '~/.skkeleton/rank.json',
       \ 'userDictionary': '~/.skkeleton/jisyo.json',
       \ 'registerConvertResult': v:true,
       \ 'showCandidatesCount': 1,
       \ })

     call skkeleton#register_kanatable('rom', {
       \ "z\<Space>": ["\u3000", ''],
       \ "<M-s>" : "disable",
       \ "<M-k>" : "katakana",
       \ })
 
     call skkeleton#register_keymap('input', '<S-l>', v:false)
endfunction

function! s:changeSource2Skk() abort
    if !exists('s:bef_buffer')
        let s:bef_buffer = ddc#custom#get_current()
    endif

    let s:skkSources = ['skkeleton', 'around']

    if executable('rg') 
        let s:skkSources = add(s:skkSources, 'rg')
    endif
    
    call ddc#custom#set_buffer({
        \ 'sources': s:skkSources,
        \ 'ui': g:ui,
        \ 'sourceOptions': {
        \   'skkeleton': {
        \     'mark': '[skkeleton]',
        \     'matchers': ['skkeleton'],
        \     'sorters': [],
        \     'minAutoCompleteLength': 1,
        \     'isVolatile': v:true
        \   },
        \ }})
    call DdcMappingChange(v:false)
    call pum#set_option('auto_select', v:false)
endfunction

function! s:changeSkk2Source() abort
    " Restore sources
    if exists('s:bef_buffer')
        call ddc#custom#set_buffer(s:bef_buffer)
        unlet s:bef_buffer
    else
        call ddc#custom#set_buffer(ddc#custom#get_current())
    endif
    call DdcMappingChange(v:false)
    call pum#set_option('auto_select', v:false)
endfunction

call s:skkeleton_init()
augroup skkeleton-initialize-pre
  autocmd!
  autocmd User skkeleton-initialize-pre call s:skkeleton_init()
  autocmd User skkeleton-enable-pre call s:changeSource2Skk()
  autocmd User skkeleton-disable-pre call s:changeSkk2Source()
augroup END 
" }}}

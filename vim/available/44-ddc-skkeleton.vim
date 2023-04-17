inoremap }e <Plug>(skkeleton-enable)
inoremap }t <Plug>(skkeleton-toggle)
cnoremap }e <Plug>(skkeleton-enable)
cnoremap }t <Plug>(skkeleton-toggle)
tnoremap }e <Plug>(skkeleton-enable)
tnoremap }t <Plug>(skkeleton-toggle)

function! s:skkeleton_init() abort
     call skkeleton#config({
       \ 'eggLikeNewline': v:false,
       \ 'globalDictionaries': ['/usr/share/skk/SKK-JISYO.L','/usr/share/skk/SKK-JISYO.S','/usr/share/skk/SKK-JISYO.M' ,'/usr/share/skk/SKK-JISYO.ML' ],
       \ 'completionRankFile': '~/.skkeleton/rank.json',
       \ 'registerConvertResult': v:true,
       \ 'showCandidatesCount': 1,
       \ })
 
     call skkeleton#register_kanatable('rom', {
       \ 'la' : ['ぁ'],
       \ 'li' : ['ぃ'],
       \ 'lu' : ['ぅ'],
       \ 'le' : ['ぇ'],
       \ 'lo' : ['ぉ'],
       \ 'ltu' : ['っ'],
       \ "z\<Space>": ["\u3000", ''],
       \ "}d" : "disable",
       \ "}k" : "katakana"
       \ })
 
     call add(g:skkeleton#mapped_keys, '<S-l>')
     call skkeleton#register_keymap('input', '<S-l>', v:false)
     call skkeleton#register_keymap('input', 'kt', 'katakana')
endfunction

function! s:changeSource2Skk() abort
    if !exists('s:bef_buffer')
        let s:bef_buffer = ddc#custom#get_current()
    endif

    let s:skkSource = ['skkeleton', 'around', 'rg']
    
    call ddc#custom#set_buffer({
        \ 'sources': s:skkSource,
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
    call DduMappingChange(v:true)
    call pum#set_option('auto_select', v:false)
endfunction

function! s:changeSkk2Source() abort
    " Restore sources
    if exists('s:bef_buffer')
        call ddc#custom#set_buffer(s:bef_buffer)
        unlet s:bef_buffer
        call ddc#disable_cmdline_completion()
    else
        call ddc#custom#set_buffer(ddc#custom#get_current())
    endif
    call DduMappingChange(v:false)
    call pum#set_option('auto_select', v:true)
endfunction

augroup skkeleton_callbacks
  autocmd!
  autocmd User skkeleton-initialize-pre call s:skkeleton_init()
  autocmd User skkeleton-enable-pre call s:changeSource2Skk()
  autocmd User skkeleton-disable-pre call s:changeSkk2Source()
augroup END 

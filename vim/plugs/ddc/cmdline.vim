" hook_add {{{

nnoremap : <Cmd>call CommandlinePre(':')<CR>:
nnoremap / <Cmd>call CommandlinePre('/')<CR>/

function! CommandlinePre(mode) abort
    " Mapping
    "
        if Global_is_plugged('pum.vim') &&  g:ui == 'pum'
            " cnoremap <Tab> <Cmd>call pum#map#select_relative(+1)<CR>
            " cnoremap <S-Tab> <Cmd>call pum#map#select_relative(-1)<CR>
            cnoremap <M-n>   <Cmd>call pum#map#select_relative(+1)<CR>
            cnoremap <M-u>   <Cmd>call pum#map#select_relative(-1)<CR>
            cnoremap <M-y>   <Cmd>call pum#map#confirm()<CR>
            cnoremap <M-e>   <Cmd>call pum#map#cancel()<CR>
            " cnoremap <CR>    <Cmd>call CmdlineCRConfirm()<CR>

            " Overwrite sources
            if !exists('b:prev_buffer_config')
                let b:prev_buffer_config = ddc#custom#get_buffer()
            endif


        else
            " " <S-TAB>: completion.
            " cnoremap <silent><expr> <S-TAB>
            " \ ddc#map#pum_visible() ? '<M-n>' :
            " \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
            " \ '<S-TAB>' : ddc#map#manual_complete()
            " 
            " " <M-TAB>: completion back.
            " cnoremap <expr><M-TAB>  ddc#map#pum_visible() ? '<M-p>' : '<M-h>'
        endif

        autocmd User DDCCmdlineLeave ++once call CommandlinePost()
        " autocmd InsertEnter <buffer> ++once call CommandlinePost()
        
        " Enable command line completion
        call ddc#enable_cmdline_completion()
endfunction

function! CommandlinePost() abort
    if Global_is_plugged("pum.vim")
        silent! cunmap <Tab>
        silent! cunmap <S-Tab>
        
        " Restore sources
        if exists('b:prev_buffer_config')
            call ddc#custom#set_buffer(b:prev_buffer_config)
            unlet b:prev_buffer_config
        else
            call ddc#custom#set_buffer({})
        endif
    endif
endfunction
" }}}

" hook_source {{{
let l:cmdlineSources = {
		    \ ':': ['cmdline_history', 'file', 'cmdline', 'around'],
		    \ '@': ['cmdline_history', 'input', 'file', 'around'],
		    \ '>': ['cmdline_history', 'input', 'file', 'around'],
		    \ '?': ['around', 'line'],
		    \ '-': ['around', 'line'],
		    \ '=': ['input'],
		    \ }
let l:cmdlineSourceOptions = #{
        \ cmdline_history: #{
        \       mark : '[cmdline_history]',
        \       minAutoCompleteLength: 0,
        \       matchers: [
        \           "matcher_head"   
        \       ],
        \       sorters: [
        \           "sorter_cmdline_history"
        \       ]
        \ },
        \ cmdline: #{
        \       mark : '[cmdline]',
        \       minAutoCompleteLength: 0,
        \       maxItems: '5000',
        \       matchers: [
        \           "matcher_head"   
        \       ],
        \       sorters: [
        \           "sorter_cmdline_history"
        \       ]
        \ },
        \}
let l:cmdlineSourceParams = #{
      \ cmdline_history: #{maxSize: 10},
      \ cmdline: #{maxSize: 10},
      \ }

call ddc#custom#patch_global('cmdlineSources', l:cmdlineSources)
call ddc#custom#patch_global('sourceOptions', l:cmdlineSourceOptions)
call ddc#custom#patch_global('sourceParams', l:cmdlineSourceParams)
" }}}

" hook_add {{{
nnoremap : <Cmd>call CommandlinePre()<CR>:

function! CommandlinePre() abort
    " Mapping
    "
    if Global_is_plugged('pum.vim') &&  g:ui == 'pum'
        " cnoremap <Tab> <Cmd>call pum#map#select_relative(+1)<CR>
        " cnoremap <S-Tab> <Cmd>call pum#map#select_relative(-1)<CR>
        cnoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
        cnoremap <C-m>   <Cmd>call pum#map#select_relative(-1)<CR>
        cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
        cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
        " cnoremap <CR>    <Cmd>call CmdlineCRConfirm()<CR>

        " Overwrite sources
        if !exists('b:prev_buffer_config')
            let b:prev_buffer_config = ddc#custom#get_buffer()
        endif

        
        autocmd User DDCCmdlineLeave ++once call CommandlinePost()
        " autocmd InsertEnter <buffer> ++once call CommandlinePost()
        
        " Enable command line completion
        call ddc#enable_cmdline_completion()
    else
        " " <S-TAB>: completion.
        " cnoremap <silent><expr> <S-TAB>
        " \ ddc#map#pum_visible() ? '<C-n>' :
        " \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
        " \ '<S-TAB>' : ddc#map#manual_complete()
        " 
        " " <C-TAB>: completion back.
        " cnoremap <expr><C-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'
    endif
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
		    \ ':': ['cmdline-history', 'file', 'cmdline', 'around'],
		    \ '@': ['cmdline-history', 'input', 'file', 'around'],
		    \ '>': ['cmdline-history', 'input', 'file', 'around'],
		    \ '/': ['around', 'line'],
		    \ '?': ['around', 'line'],
		    \ '-': ['around', 'line'],
		    \ '=': ['input'],
		    \ }
let l:cmdlineSourceOptions = #{
      \ cmdline-history: #{mark : '[cmdline-history]', minAutoCompleteLength: 0 },
      \ cmdline: #{ mark : '[cmdline]', minAutoCompleteLength: 0, maxItems: '5000' },
      \ }
let l:cmdlineSourceParams = #{
      \ cmdline-history: #{maxSize: 10},
      \ cmdline: #{maxSize: 10},
      \ }

call ddc#custom#patch_global('cmdlineSources', l:cmdlineSources)
call ddc#custom#patch_global('sourceOptions', l:cmdlineSourceOptions)
call ddc#custom#patch_global('sourceParams', l:cmdlineSourceParams)
" }}}

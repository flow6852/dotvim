let autoCompleteEvents = add(autoCompleteEvents, 'CmdlineEnter')
let autoCompleteEvents = add(autoCompleteEvents, 'CmdlineChanged')

let cmdlineSources = {
		    \ ':': ['cmdline', 'file', 'cmdline-history', 'around'],
		    \ '@': ['cmdline-history', 'input', 'file', 'around'],
		    \ '>': ['cmdline-history', 'input', 'file', 'around'],
		    \ '/': ['around', 'line'],
		    \ '?': ['around', 'line'],
		    \ '-': ['around', 'line'],
		    \ '=': ['input'],
		    \ }

call ddc#custom#patch_global('autoCompleteEvents', autoCompleteEvents)
call ddc#custom#patch_global('cmdlineSources', cmdlineSources)
 
nnoremap : <Cmd>call CommandlinePre()<CR>:

function! CommandlinePre() abort
    " Mapping
    "
    if Global_is_plugged('pum.vim') &&  g:ui == 'pum'
        cnoremap <Tab> <Cmd>call pum#map#insert_relative(+1)<CR>
        cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>

        " Overwrite sources
        if !exists('b:prev_buffer_config')
            let b:prev_buffer_config = ddc#custom#get_buffer()
        endif

        call ddc#custom#patch_buffer('sourceOptions' , { 'cmdline-history': { 'mark' : '[cmdline-history]', 'minAutoCompleteLength': 0 }})
        call ddc#custom#patch_buffer('sourceOptions' , { 'cmdline': { 'mark' : '[cmdline]', 'minAutoCompleteLength': 0, 'maxItems': '5000' }})
        call ddc#custom#patch_buffer('sourceOptions' , { 'file': { 'mark' : '[file]', 'isVolatile': v:true, 'minAutoCompleteLength': 0, 'forceCompletionPattern': '\S/\S*' }})
        call ddc#custom#patch_buffer('sourceOptions' , { 'input': { 'mark' : '[input]' }})
        call ddc#custom#patch_buffer('sourceOptions' , { 'line': { 'mark' : '[line]' }})
        call ddc#custom#patch_buffer('sourceParams' , {'cmdline-history': {'maxSize': 10}} )
        call ddc#custom#patch_buffer('sourceParams' , {'cmdline': {'maxSize': 10}} )
        call ddc#custom#patch_buffer('sourceParams' , {'input': {'maxSize': 10}} )
        call ddc#custom#patch_buffer('sourceParams' , {'line': {'maxSize': 10}} )
        call ddc#custom#patch_buffer('sourceParams' , {'file': {'maxSize': 10}} )
        call ddc#custom#patch_buffer('sourceParams' , {'around': {'maxSize': 10}} )
        
        autocmd User DDCCmdlineLeave ++once call CommandlinePost()
        autocmd InsertEnter <buffer> ++once call CommandlinePost()
        
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
            call ddc#disable_cmdline_completion()
        else
            call ddc#custom#set_buffer({})
        endif
    endif
endfunction


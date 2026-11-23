" hook_source {{{
let s:pum_option = #{
    \   auto_select: v:false,
    \   max_height: 10
    \ }
call pum#set_option(s:pum_option)

inoremap <silent><expr><M-y> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'

inoremap <expr><Tab>
  \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
  \ '<Tab>'
inoremap <expr><S-Tab>   '<Cmd>call pum#map#insert_relative(-1)<CR>'
inoremap <M-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <M-u>   <Cmd>call pum#map#insert_relative(-1)<CR>

inoremap <M-e>   <Cmd>call pum#map#cancel()<CR>
inoremap <expr><Esc> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<Esc>'

" Rotate sources

function RotateCmpSources()
    let l:set_buffer = goda_cmp#get_current()

    let l:mode = mode()
    let l:option = ''
    if l:mode ==# 'c'
        let l:option = getcmdtype()
    endif

    if l:set_buffer != {}
        if len(l:option) > 0 
            let l:set_buffer['cmdlineSources'][l:option] = add(slice(l:set_buffer['cmdlineSources'][l:option], 1), l:set_buffer['cmdlineSources'][l:option][0])
        else
            let l:set_buffer['sources'] = add(slice(l:set_buffer['sources'], 1), l:set_buffer['sources'][0])
        endif
        call goda_cmp#set_buffer(l:set_buffer)
        call goda_cmp#map#manual_complete()
    endif
endfunction

" cmdline

nnoremap : <Cmd>call CommandlinePre(':')<CR>:
nnoremap / <Cmd>call CommandlinePre('/')<CR>/

function! CommandlinePre(mode) abort
    " Mapping
    "
    cnoremap <Tab> <Cmd>call pum#map#insert_relative(+1)<CR>
    cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
    cnoremap <M-n>   <Cmd>call pum#map#select_relative(+1)<CR>
    cnoremap <M-u>   <Cmd>call pum#map#select_relative(-1)<CR>
    cnoremap <M-y>   <Cmd>call pum#map#confirm()<CR>
    cnoremap <M-e>   <Cmd>call pum#map#cancel()<CR>
    cnoremap <expr><Esc> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<C-c>'
    call goda_cmp#enable_cmdline()
          " cnoremap <CR>    <Cmd>call CmdlineCRConfirm()<CR>

          " Overwrite sources

      " autocmd InsertEnter <buffer> ++once call CommandlinePost()
      
      " Enable command line completion
endfunction

function! CommandlinePost() abort
    silent! cunmap <Tab>
    silent! cunmap <S-Tab>
endfunction

autocmd VimEnter * call goda_cmp#enable()
" }}}

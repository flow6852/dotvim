" You must set the default ui.
" Note: ff ui
" https://github.com/Shougo/ddu-ui-ff
    
" filer-option
" split : floating or vertical

call ddu#custom#patch_global({
    \   'kindOptions': {
    \     'file': {
    \       'defaultAction': 'open',
    \     },
    \     'url' : {
    \       'defaultAction': 'open',
    \     },
    \     'vimcmd' : {
    \       'defaultAction': 'vimcmd',
    \     },
    \   },
    \   })

" fuze finder spliter
function Ddu_custom_cfg(split, previewSplit, isPreview)
    let uiParams = {
    \     'ff': {
    \       'split': has('nvim') ? a:split : a:previewSplit,
    \       'startFilter': v:false,
    \       'highlights': {'selected': 'Statement'},
    \       'autoAction': a:isPreview ? {'name':'preview'} : {},
    \       'winCol': &columns/8 ,
    \       'winWidth': a:split == 'floating' && has('nvim')  ? (a:previewSplit == 'vertical' && a:isPreview ? 3*&columns/8 : 3*&columns/4) : 15 ,
    \       'winRow': &lines/8,
    \       'winHeight': a:split == 'floating' && has('nvim') ? (a:previewSplit == 'horizontal' && a:isPreview ? 3*&lines/8 : 3*&lines/4) : 10 ,
    \       'previewFloating':  a:isPreview && a:split == 'floating' && has('nvim') ? v:true : v:false,
    \       'previewSplit': has('nvim') ? a:previewSplit : 'no',
    \       'previewWidth': a:split == 'floating' && has('nvim') ? (a:previewSplit == 'vertical' && a:isPreview ? 3*&columns/8: 3*&columns/4) : 10,
    \       'previewHeight': a:split == 'floating' && has('nvim') ? (a:previewSplit == 'horizontal' && a:isPreview ? 3*&lines/8: 3*&lines/4) : 10,
    \       'splitDirection': a:previewSplit == 'vertical' ? "topleft": "botright"
    \     }
    \  }

    let ret = {
    \   'ui': 'ff',
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring'],
    \     },
    \   },
    \   'uiParams' : uiParams,
    \   'kindOptions': {
    \     '_': {
    \       'defaultAction': 'open',
    \     },
    \   }
    \ }

    return ret
endfunction

" keymapping
augroup DduKeyMap
  au!
  autocmd FileType ddu-ff call s:ddu_my_settings()
augroup End

function! s:ddu_my_settings() abort
  " file
  nnoremap <buffer><silent> <CR>
    \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>

  nnoremap <buffer><silent> ;i
    \ <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>

  nnoremap <buffer><silent> ;p
    \ <Cmd>call ddu#ui#do_action('preview')<CR>

  nnoremap <buffer><silent> ;h
    \ <Cmd>call ddu#ui#multi_actions()

  nnoremap <buffer><silent> ;<Space>
    \ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>

  nnoremap <buffer><silent> <Esc>
    \ <Cmd>call ddu#ui#do_action('quit')<CR>

  " GET
  nnoremap <buffer><silent> ;g
    \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'fetchUnstable', 'params': {'showHeader': v:true}})<CR>

  " submit
  nnoremap <buffer><silent> ;s
    \ <Cmd>call StatusAfterSubmit(v:true)<CR>

  nnoremap <buffer><silent> ;t
    \ <Cmd>call ddu#ui#multi_actions([['itemAction', {'name': 'runTests', 'params': {'actionFlag': 'Persist'}}], ['preview', {'kind': 'runTests'}]])<CR>

  nnoremap <buffer><silent> ;r
    \ <Cmd>call ddu#redraw(expand('%'))<CR>

  nnoremap <buffer><silent> ;v
    \ <Cmd>call ddu#ui#do_action('getItem')<CR>
    
  nnoremap <buffer><silent> <C-c>
              \ <Cmd>call ddu#ui#do_action('itemAction', {'name': 'setcmdline'})<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
  inoremap <buffer><silent> <CR> <Esc><Cmd>close<CR>
  inoremap <buffer><silent> <Esc> <Esc><Cmd>close<CR>

  nnoremap <buffer><silent> <CR> <Cmd>close<CR>
  nnoremap <buffer><silent> <Esc> <Cmd>close<CR>
endfunction

function! StatusAfterSubmit(arg) abort
    call ddu#ui#multi_actions([['getItem'], ['itemAction', {'name': 'submit', 'params': {'actionFlag': 'Persist'}}]])
    if a:arg
        call ddu#start({'name': 'atcoder_facilitator', 'sources': [{'name': 'atcoder_status', 'options':{'matchers': ['matcher_substring']}}]})
        call atcoder_facilitator#statusAfterSubmit(get(get(b:ddu_ui_item, "action"), "qdict"), a:arg)
    else
        call atcoder_facilitator#statusAfterSubmit(get(get(b:ddu_ui_item, "action"), "qdict"), a:arg)
    endif
endfunction

function DduOpenWithPreview(name, sources)
    call ddu#start({'name':a:name, 'sources' : a:sources})
endfunction

inoremap <C-l> <Cmd>call ddu#start(#{
\   name: 'ddc',
\   ui: 'ff',
\   input: matchstr(getline('.')[: col('.') - 1], '\k*$'),
\   sources: [
\     #{ name: 'ddc', options: #{ defaultAction: 'complete' } },
\   ],
\   uiParams: #{
\     ff: #{
\       startFilter: v:true,
\       replaceCol: match(getline('.')[: col('.') - 1], '\k*$') + 1,
\     },
\   },
\ })<CR>

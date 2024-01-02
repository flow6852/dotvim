" hook_source {{{
" You must set the default ui.
" Note: ff ui
" https://github.com/Shougo/ddu-ui-ff
    
" filer-option
" split : floating or vertical

" fuze finder spliter
"

call ddu#custom#patch_local('vsplit', #{
    \ ui : 'ff',
    \ sourceOptions: #{
    \     _: #{
    \       matchers: ['matcher_substring'],
    \       converters: ['converter_display_word', 'converter_kind'],
    \     },
    \   },
    \ kindOptions: #{
    \     _: #{
    \       defaultAction: 'open',
    \     },
    \   },
    \ uiParams: #{
    \     ff: #{
    \       split: has('nvim') ? 'floating' : 'vsplit',
    \       startFilter: v:false,
    \       highlights: #{ selected: 'Statement'},
    \       autoAction: #{ name: 'preview'},
    \       winCol: 0 ,
    \       winWidth: has('nvim') ? 20 : 15 ,
    \       winRow: 1,
    \       winHeight: has('nvim') ? &lines : &lines ,
    \       previewFloating: has('nvim') ? v:true : v:false,
    \       previewSplit: has('nvim') ? 'horizontal' : 'no',
    \       previewWidth: has('nvim') ? &columns-20 : 10,
    \       previewHeight: has('nvim') ? &lines : &lines,
    \       splitDirection: "topleft"
    \     }
    \   }
    \ })

call ddu#custom#patch_local('split', #{
    \ ui : 'ff',
    \ sourceOptions: #{
    \     _: #{
    \       matchers: ['matcher_substring'],
    \       converters: ['converter_display_word', 'converter_kind'],
    \     },
    \   },
    \ kindOptions: #{
    \     lsp_codeAction: #{
    \       defaultAction: 'apply',
    \     },
    \     _: #{
    \       defaultAction: 'open',
    \     },
    \   },
    \ uiParams: #{
    \     ff: #{
    \       split: has('nvim') ? 'floating' : 'split',
    \       startFilter: v:false,
    \       highlights: #{ selected: 'Statement'},
    \       autoAction: #{ name: 'preview'},
    \       winCol: 0 ,
    \       winWidth: has('nvim') ? &columns : 15 ,
    \       winRow: has('nvim') ? 5*&lines/8-1 : 10,
    \       winHeight: has('nvim') ? 3*&lines/8 : 10 ,
    \       previewFloating: has('nvim') ? v:true : v:false,
    \       previewSplit: has('nvim') ? 'horizontal' : 'no',
    \       previewCol: &columns/2, 
    \       previewWidth: has('nvim') ? &columns/2 : 10,
    \       previewRow: 0,
    \       previewHeight: has('nvim') ? 5*&lines/8-2 : 10,
    \       splitDirection: "topleft"
    \     }
    \   }
    \ })
" }}}


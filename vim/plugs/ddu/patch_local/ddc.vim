call ddu#custom#patch_local('ddc', #{
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
    \ })

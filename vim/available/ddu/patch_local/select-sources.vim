call ddu#custom#patch_local('select-sources', 'uiParams', Ddu_uiParams('vertical', 3*&columns/4, 10, v:false, 'horizontal', 3*&columns/8, 3*&lines/4 - 10))
call ddu#custom#patch_local('select-sources', 'kindOptions', #{
    \     custom-list: #{
    \       defaultAction: 'callback',
    \     },
    \   }
    \ )

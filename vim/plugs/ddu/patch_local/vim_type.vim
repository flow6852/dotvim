call ddu#custom#patch_local('vim_type', extend(
    \ Ddu_custom_cfg('floating',  &columns, 10, v:true, 'horizontal', &columns, &lines - 10), 
    \ {'sources': [ {'name': 'vim_variable'},
                  \ {'name': 'vim_option'},
                  \ {'name': 'vim_function', 'params': {'pattern': 'ddu'}},
                  \ {'name': 'vim_command'},
                  \ {'name': 'vim_event'}]}))
call ddu#custom#patch_local('help', extend(Ddu_custom_cfg('floating',  &columns, 10, v:true, 'horizontal', &columns, &lines - 10), {'sources': [{'name': 'help'}]}))

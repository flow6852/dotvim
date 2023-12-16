call ddu#custom#patch_local('window', 'uiParams', Ddu_uiParams('floating', 15, &lines, v:true, 'vertical',&columns-15, &lines))
call ddu#custom#patch_local('window', 'sources', [#{name: 'window',}])

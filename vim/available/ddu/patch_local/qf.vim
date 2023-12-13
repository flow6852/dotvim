call ddu#custom#patch_local('qf', 'uiParams', Ddu_uiParams('floating',  &columns, 3*&lines/8, v:true, 'horizontal', &columns, 5*&lines/8))
call ddu#custom#patch_local('quickfix_history', 'uiParams', Ddu_uiParams('floating',  &columns, 3*&lines/8, v:true, 'horizontal', &columns, 5*&lines/8))
#  function Ddu_uiParams(split, width, height, isPreview, previewSplit, previewWidth, previewHeight)

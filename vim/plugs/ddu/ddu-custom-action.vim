call ddu#custom#action('kind', 'file', 'test',
		    \ { args -> execute('let g:test =  ' . string(args) )})
call ddu#custom#action('kind', 'help', 'vim_type_chain',
            \ {args -> ddu#start({'name': 'vim_type',
                                \ 'input': match(get(get(args, 'items')[0], 'word'), ':') == 0
                                    \ ? get(get(args, 'items')[0], 'word')[1:len(get(get(args, 'items')[0], 'word'))]
                                    \ : get(get(args, 'items')[0], 'word')})})
call ddu#custom#action('source', 'quickfix_history', 'qf_chain',
            \ {args -> ddu#start({'name': 'qf', 'sources': map(copy(get(args, 'items')), 
                               \ {key, val -> {'name': 'qf', 'params': {'what': {'id': get(get(val, 'action'), 'id')}}}})})})
call ddu#custom#action('kind', 'vim_type', 'help_chain',
            \ {args -> ddu#start({'name': 'help', 'input': get(get(args, 'items')[0], 'word')})})

" hook_source {{{
call pum#set_option('auto_select', v:false)
let l:sources = ['around']

" Mappings
let sourceOptions = #{
      \ _: #{ matchers: ['matcher_editdistance'],
      \       converters: ['converter_remove_overlap'],
      \       isVolatile: v:true,
      \     },
      \ around: #{mark: '[around]'},
      \ }

let l:sourceParams = #{around: #{maxSize: 10000}}

call ddc#custom#patch_global("sources", l:sources)
call ddc#custom#patch_global("sourceOptions", l:sourceOptions)
call ddc#custom#patch_global("sourceParams", l:sourceParams)

call ddc#enable()

source $BASE_DIR/plugs/ddc/global.vim
" }}}

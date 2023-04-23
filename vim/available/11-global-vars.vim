" confortable-motion
" let g:comfortable_motion_scroll_down_key = "j"
" let g:comfortable_motion_scroll_up_key = "k"
" nnoremap <silent> <C-j> :call comfortable_motion#flick(100)<CR>
" nnoremap <silent> <C-k> :call comfortable_motion#flick(-100)<CR>
let g:atcoder_facilitator#buildCmd = ["cargo", "build", "--release", "--offline", "--quiet", "--manifest-path=./Cargo.toml"]
let g:atcoder_facilitator#execCmd = ["./target/release/main"]
" echom g:atcoder_facilitator#execCmd
" echom g:atcoder_facilitator#buildCmd

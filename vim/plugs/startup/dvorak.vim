" dvorak key remap
let dvorak_check = system("setxkbmap -print | grep dvorak")
if (dvorak_check != "")
    nnoremap d h
    nnoremap h j
    nnoremap t k
    nnoremap n l
    nnoremap k d
    nnoremap kk dd
    nnoremap l t
    nnoremap j n
    
    vnoremap d h
    vnoremap h j
    vnoremap t k
    vnoremap n l
    vnoremap k d
    vnoremap kk dd
    vnoremap l t
    vnoremap j n
endif

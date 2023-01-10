autocmd WinLeave * if (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | cclose | endif

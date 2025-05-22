" let &shell= executable('pwsh.exe') ? 'pwsh.exe' : 'powershell.exe'
let &shell= 'powershell.exe'
let &shellcmdflag='-NoLogo -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
let &shellxquote=""

set fileencodings=cp932,sjis,ucs-bom,utf-8,default,latin1
set fileencoding=cp932

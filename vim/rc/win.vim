let &shell= executable('pwsh.exe') ? 'pwsh.exe' : 'powershell.exe'
let &shellcmdflag='-NoLogo -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
let &shellxquote=""

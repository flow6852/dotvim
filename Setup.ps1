$BackupDir="$HOME\.cache\nvim\old"

New-Item $BackupDir -Type directory

Remove-Item "$BackupDir\vimrc"
Remove-Item "$BackupDir\init.vim"
Remove-Item "$BackupDir\vim" -Recurse

Move-Item "$HOME\.vimrc" "$BackupDir\vimrc"
Move-Item "$HOME\AppData\Local\nvim\init.vim" "$BackupDir\init.vim"
Move-Item "$HOME\.vim" "$BackupDir\vim"

Copy-Item "vimrc" "$HOME\.vimrc"
Copy-Item "init.vim" "$HOME\AppData\Local\nvim\init.vim"
Copy-Item "vim" "$HOME\.vim" -Recurse

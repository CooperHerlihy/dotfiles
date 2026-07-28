@echo off

powershell -Command "$upath=[Environment]::GetEnvironmentVariable('PATH','User'); $new=($upath -split ';' | Where-Object {$_ -ne '%USERPROFILE%\scripts'}) -join ';'; [Environment]::SetEnvironmentVariable('PATH',$new,'User')"

if exist "%USERPROFILE%\scripts" rmdir /s /q "%USERPROFILE%\scripts"

if exist "%APPDATA%\.emacs.d" rmdir /s /q "%APPDATA%\.emacs.d"

if exist "%LOCALAPPDATA%\nvim" rmdir /s /q "%LOCALAPPDATA%\nvim"

echo Dotfiles uninstalled successfully.

@echo off

powershell -Command "[Environment]::SetEnvironmentVariable('PATH', '%USERPROFILE%\scripts;' + [Environment]::GetEnvironmentVariable('PATH','User'), 'User')"

if exist "%USERPROFILE%\scripts" (
    rmdir /s /q "%USERPROFILE%\scripts"
)
mklink /j "%USERPROFILE%\scripts" "scripts-win"

if exist "%APPDATA%\.emacs.d" (
    rmdir /s /q "%ADDPATA%\.emacs.d"
)
mklink /j "%APPDATA%\.emacs.d" "emacs"


if exist "%LOCALAPPDATA%\nvim" (
    rmdir /s /q "%LOCALADDPATA%\nvim"
)
mklink /j "%LOCALAPPDATA%\nvim" "nvim"

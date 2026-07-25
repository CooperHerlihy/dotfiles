@echo off
set "REPO_ROOT=%~dp0.."

powershell -Command "[Environment]::SetEnvironmentVariable('PATH', '%USERPROFILE%\scripts;' + [Environment]::GetEnvironmentVariable('PATH','User'), 'User')"

if exist "%USERPROFILE%\scripts" rmdir /s /q "%USERPROFILE%\scripts"
mklink /j "%USERPROFILE%\scripts" "%REPO_ROOT%\windows\scripts"

if exist "%APPDATA%\.emacs.d" rmdir /s /q "%APPDATA%\.emacs.d"
mklink /j "%APPDATA%\.emacs.d" "%REPO_ROOT%\.config\emacs"

if exist "%LOCALAPPDATA%\nvim" rmdir /s /q "%LOCALAPPDATA%\nvim"
mklink /j "%LOCALAPPDATA%\nvim" "%REPO_ROOT%\.config\nvim"

echo Dotfiles installed successfully.

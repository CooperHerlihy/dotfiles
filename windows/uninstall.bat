@echo off

powershell -Command "$upath=[Environment]::GetEnvironmentVariable('PATH','User'); $new=($upath -split ';' | Where-Object {$_ -ne '%USERPROFILE%\scripts'}) -join ';'; [Environment]::SetEnvironmentVariable('PATH',$new,'User')"

rmdir "%USERPROFILE%\scripts"

rmdir "%USERPROFILE%\AppData\Roaming\.emacs.d"

@echo off

for %%a in (%*) do (
    if "%%a"=="push" (
        cd "%USERPROFILE%\notes"
        git add .
        git commit -m "%DATE% %TIME%"
        git push
        exit /B 0
    )
    if "%%a"=="pull" (
        cd "%USERPROFILE%\notes"
        git pull
        exit /B 0
    )
)

echo Usage: notes [push] [pull]
exit /B 1

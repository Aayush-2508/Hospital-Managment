@echo off
REM Script to push all files to GitHub one by one with individual commits

setlocal enabledelayedexpansion

REM Initialize git if needed
if not exist .git (
    echo Initializing git repository...
    git init
    git branch -M main
)

echo Pushing files to GitHub one by one...
echo.

REM Use for /R to recursively get all files
setlocal enabledelayedexpansion
set counter=0

for /R %%F in (*) do (
    set "file=%%F"
    set "filename=%%~nxF"
    
    REM Skip git folder and batch files
    if "!file:\.git=!" == "!file!" if "!filename!" neq "push-to-github.bat" if "!filename!" neq "push-to-github.ps1" (
        set /a counter+=1
        
        echo [!counter!] Adding: !file!
        
        REM Add and commit each file
        git add "!file!"
        git commit -m "Add !file!"
        
        echo.
    )
)

echo.
echo Pushing all commits to GitHub...
git push -u origin main

echo.
echo All files have been pushed to GitHub!
pause

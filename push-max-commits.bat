@echo off
REM Script to push files to GitHub with maximum commits
REM Step 1: Create initial commit with first file
REM Step 2: Push each remaining file one by one

setlocal enabledelayedexpansion

set "FIRST_FILE=README.md"

echo Initializing git repository...
if not exist .git (
    git init
    git branch -M main
)

echo.
echo === STEP 1: Creating initial commit with first file ===
echo Adding: %FIRST_FILE%
git add "%FIRST_FILE%"
git commit -m "Initial commit: Add %FIRST_FILE%"
echo.

echo === STEP 2: Pushing initial commit ===
git push -u origin main
echo.

echo === STEP 3: Adding remaining files one by one ===
set counter=0

for /R %%F in (*) do (
    set "file=%%F"
    set "filename=%%~nxF"
    
    REM Skip git folder, batch files, and the first file
    if "!file:\.git=!" == "!file!" (
        if "!filename!" neq "push-to-github.bat" (
            if "!filename!" neq "push-to-github.ps1" (
                if "!filename!" neq "%FIRST_FILE%" (
                    set /a counter+=1
                    
                    echo [!counter!] Adding: !file!
                    git add "!file!"
                    git commit -m "Add !file!"
                    echo.
                )
            )
        )
    )
)

echo === STEP 4: Pushing all commits ===
git push

echo.
echo All files have been successfully pushed to GitHub!
pause

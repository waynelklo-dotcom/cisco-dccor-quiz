@echo off
REM ============================================================
REM  Cisco DC Quiz - one-click deploy
REM  Usage: edit your files, then double-click this file
REM ============================================================

cd /d "%~dp0"

echo.
echo === Checking for changes ===
git diff --cached --quiet
if errorlevel 1 (
    echo Staged changes detected, skipping add.
) else (
    git diff --quiet
    if errorlevel 1 (
        echo.
        echo === Staging all changes ===
        git add .
    ) else (
        echo No changes to deploy.
        pause
        exit /b 0
    )
)

echo.
echo === Current diff summary ===
git diff --cached --stat

echo.
set /p MSG="Commit message (or Enter for 'update'): "
if "%MSG%"=="" set MSG=update

echo.
echo === Committing ===
git commit -m "%MSG%"
if errorlevel 1 (
    echo.
    echo Nothing to commit (maybe nothing was staged).
    pause
    exit /b 1
)

echo.
echo === Pushing to GitHub ===
git push
if errorlevel 1 (
    echo.
    echo *** Push failed! Check the error above. ***
    pause
    exit /b 1
)

echo.
echo === Done! ===
echo GitHub Pages will rebuild in ~1 minute.
echo.
pause

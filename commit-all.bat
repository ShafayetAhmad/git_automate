@echo off
setlocal enabledelayedexpansion

:: Define the root folder to search for subfolders with .git folders
set "root_folder=C:\path\to\your\root\folder"

:: Function to check if a folder contains a .git folder
:has_git_folder
set "folder=%~1"
if exist "!folder!\.git\" (
    exit /b 0  :: Return success (0) if .git folder found
) else (
    exit /b 1  :: Return failure (1) if .git folder not found
)

:: Loop through all subfolders in the root folder
for /d %%D in ("%root_folder%\*") do (
    call :has_git_folder "%%D"
    if !errorlevel! equ 0 (
        echo Found .git folder in "%%D"
        cd /d "%%D"

        :: Perform Git actions
        git pull
        git add .
        git commit -m "add all"
        git push

        cd /d "%root_folder%"  :: Return to the root folder
    )
)

echo Finished processing all subfolders.

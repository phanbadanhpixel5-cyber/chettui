@echo off
REM TAO Device Controller - GitHub Setup Script (Windows)
REM This script helps you push your project to GitHub

color 0A
cls

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║     TAO Device Controller - GitHub Setup Script (Windows)      ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

REM Check if git is initialized
if not exist ".git" (
    echo [*] Git repository not found. Initializing...
    call git init
    echo [✓] Git repository initialized
) else (
    echo [✓] Git repository already initialized
)

echo.
echo [*] Step 1: Configure Git User
echo ─────────────────────────────────────────

for /f "tokens=*" %%A in ('git config user.name 2^>nul') do set git_name=%%A

if "%git_name%"=="" (
    set /p git_name="Enter your name (for Git commits): "
    call git config user.name "%git_name%"
    echo [✓] Git user name set to: %git_name%
) else (
    echo [✓] Git user already configured: %git_name%
)

for /f "tokens=*" %%A in ('git config user.email 2^>nul') do set git_email=%%A

if "%git_email%"=="" (
    set /p git_email="Enter your email (for Git commits): "
    call git config user.email "%git_email%"
    echo [✓] Git user email set to: %git_email%
) else (
    echo [✓] Git email already configured: %git_email%
)

echo.
echo [*] Step 2: Check Repository Status
echo ─────────────────────────────────────────
call git status

echo.
echo [*] Step 3: Add Files to Git
echo ─────────────────────────────────────────

call git add .
echo [✓] All files added to staging

echo.
echo [*] Step 4: Commit Changes
echo ─────────────────────────────────────────

set /p commit_msg="Enter commit message (or press Enter for default): "

if "%commit_msg%"=="" (
    set commit_msg=Initial commit: TAO Device Controller - complete IoT management system
)

call git commit -m "%commit_msg%"
echo [✓] Changes committed

echo.
echo [*] Step 5: Add Remote Repository
echo ─────────────────────────────────────────

call git remote -v | find "origin" >nul
if not errorlevel 1 (
    echo [!] Remote 'origin' already exists:
    call git remote -v
    set /p replace_remote="Do you want to replace it? (y/n): "
    if /i "%replace_remote%"=="y" (
        call git remote remove origin
        echo [✓] Remote 'origin' removed
    ) else (
        echo [!] Skipping remote setup
        echo.
        echo [*] Next steps:
        echo 1. Create a new repository on GitHub.com
        echo 2. Copy the repository URL
        echo 3. Run: git remote add origin ^<YOUR_REPOSITORY_URL^>
        echo 4. Run: git push -u origin main
        pause
        exit /b 0
    )
)

set /p github_url="Enter your GitHub repository URL: "

if "%github_url%"=="" (
    echo [✗] Repository URL cannot be empty
    pause
    exit /b 1
)

call git remote add origin "%github_url%"
echo [✓] Remote 'origin' added: %github_url%

echo.
echo [*] Step 6: Set Main Branch
echo ─────────────────────────────────────────

call git branch -M main
echo [✓] Branch set to 'main'

echo.
echo [*] Step 7: Push to GitHub
echo ─────────────────────────────────────────

set /p proceed_push="Ready to push to GitHub? (y/n): "

if /i "%proceed_push%"=="y" (
    call git push -u origin main
    
    if errorlevel 0 (
        echo.
        echo [✓] Successfully pushed to GitHub!
        echo.
        echo ═══════════════════════════════════════════════════════════════
        echo   Your project is now on GitHub! 🎉
        echo ═══════════════════════════════════════════════════════════════
        echo.
        echo Repository URL: %github_url%
        echo.
        echo Next steps:
        echo 1. Go to your GitHub repository
        echo 2. Add collaborators if needed
        echo 3. Set up GitHub Actions for CI/CD
        echo 4. Create issues to track tasks
        echo.
        echo For more information, see: GITHUB_SETUP_GUIDE.md
    ) else (
        echo [✗] Failed to push to GitHub
        echo Make sure you have:
        echo 1. Created the repository on GitHub
        echo 2. Entered the correct repository URL
        echo 3. Configured your GitHub credentials
    )
) else (
    echo [!] Push cancelled
    echo.
    echo To push later, run:
    echo   git push -u origin main
)

echo.
echo [*] Verification
echo ─────────────────────────────────────────
echo Remote configuration:
call git remote -v
echo.
echo Latest commit:
call git log -1 --oneline
echo.
echo Branch:
call git branch

pause

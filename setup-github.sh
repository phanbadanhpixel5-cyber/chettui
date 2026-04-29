#!/bin/bash

# TAO Device Controller - GitHub Setup Script
# This script helps you push your project to GitHub

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     TAO Device Controller - GitHub Setup Script               ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}Git repository not found. Initializing...${NC}"
    git init
    echo -e "${GREEN}✓ Git repository initialized${NC}"
else
    echo -e "${GREEN}✓ Git repository already initialized${NC}"
fi

echo ""
echo -e "${BLUE}Step 1: Configure Git User${NC}"
echo "─────────────────────────────────────────"

# Check if git user is configured
if ! git config user.name &> /dev/null; then
    read -p "Enter your name (for Git commits): " git_name
    git config user.name "$git_name"
    echo -e "${GREEN}✓ Git user name set to: $git_name${NC}"
else
    git_name=$(git config user.name)
    echo -e "${GREEN}✓ Git user already configured: $git_name${NC}"
fi

if ! git config user.email &> /dev/null; then
    read -p "Enter your email (for Git commits): " git_email
    git config user.email "$git_email"
    echo -e "${GREEN}✓ Git user email set to: $git_email${NC}"
else
    git_email=$(git config user.email)
    echo -e "${GREEN}✓ Git email already configured: $git_email${NC}"
fi

echo ""
echo -e "${BLUE}Step 2: Check Repository Status${NC}"
echo "─────────────────────────────────────────"

git status

echo ""
echo -e "${BLUE}Step 3: Add Files to Git${NC}"
echo "─────────────────────────────────────────"

git add .
echo -e "${GREEN}✓ All files added to staging${NC}"

echo ""
echo -e "${BLUE}Step 4: Commit Changes${NC}"
echo "─────────────────────────────────────────"

read -p "Enter commit message (default: 'Initial commit: TAO Device Controller'): " commit_msg
commit_msg=${commit_msg:-"Initial commit: TAO Device Controller - complete IoT management system"}

git commit -m "$commit_msg"
echo -e "${GREEN}✓ Changes committed${NC}"

echo ""
echo -e "${BLUE}Step 5: Add Remote Repository${NC}"
echo "─────────────────────────────────────────"

# Check if remote already exists
if git remote -v | grep -q origin; then
    echo -e "${YELLOW}Remote 'origin' already exists:${NC}"
    git remote -v
    read -p "Do you want to replace it? (y/n): " replace_remote
    if [ "$replace_remote" = "y" ]; then
        git remote remove origin
        echo -e "${GREEN}✓ Remote 'origin' removed${NC}"
    else
        echo -e "${YELLOW}Skipping remote setup${NC}"
        echo ""
        echo -e "${BLUE}Next steps:${NC}"
        echo "1. Create a new repository on GitHub.com"
        echo "2. Copy the repository URL"
        echo "3. Run: git remote add origin <YOUR_REPOSITORY_URL>"
        echo "4. Run: git push -u origin main"
        exit 0
    fi
fi

read -p "Enter your GitHub repository URL: " github_url

if [ -z "$github_url" ]; then
    echo -e "${RED}✗ Repository URL cannot be empty${NC}"
    exit 1
fi

git remote add origin "$github_url"
echo -e "${GREEN}✓ Remote 'origin' added: $github_url${NC}"

echo ""
echo -e "${BLUE}Step 6: Set Main Branch${NC}"
echo "─────────────────────────────────────────"

git branch -M main
echo -e "${GREEN}✓ Branch set to 'main'${NC}"

echo ""
echo -e "${BLUE}Step 7: Push to GitHub${NC}"
echo "─────────────────────────────────────────"

read -p "Ready to push to GitHub? (y/n): " proceed_push

if [ "$proceed_push" = "y" ]; then
    git push -u origin main
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Successfully pushed to GitHub!${NC}"
        echo ""
        echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
        echo -e "${GREEN}  Your project is now on GitHub! 🎉${NC}"
        echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
        echo ""
        echo "Repository URL: $github_url"
        echo ""
        echo "Next steps:"
        echo "1. Go to your GitHub repository"
        echo "2. Add collaborators if needed"
        echo "3. Set up GitHub Actions for CI/CD"
        echo "4. Create issues to track tasks"
        echo ""
        echo "For more information, see: GITHUB_SETUP_GUIDE.md"
    else
        echo -e "${RED}✗ Failed to push to GitHub${NC}"
        echo "Make sure you have:"
        echo "1. Created the repository on GitHub"
        echo "2. Entered the correct repository URL"
        echo "3. Configured your GitHub credentials"
    fi
else
    echo -e "${YELLOW}Push cancelled${NC}"
    echo ""
    echo "To push later, run:"
    echo "  git push -u origin main"
fi

echo ""
echo -e "${BLUE}Verification${NC}"
echo "─────────────────────────────────────────"
echo "Remote configuration:"
git remote -v
echo ""
echo "Latest commit:"
git log -1 --oneline
echo ""
echo "Branch:"
git branch

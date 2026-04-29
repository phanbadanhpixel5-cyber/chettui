# GitHub Setup Guide - TAO Device Controller

## 📋 Overview

This guide will help you push the TAO Device Controller project to GitHub and set up your remote repository.

## ✅ Prerequisites

- GitHub account (create at github.com if you don't have one)
- Git installed on your machine
- GitHub Personal Access Token or SSH key configured

## 🚀 Quick Start (5 Minutes)

### Step 1: Create GitHub Repository

1. Go to [GitHub.com](https://github.com)
2. Click **+** icon in top right → **New repository**
3. Fill in details:
   - **Repository name**: `tao-device-controller`
   - **Description**: "Complete IoT device management system with Flutter, Node.js, and Arduino"
   - **Visibility**: Public (or Private if you prefer)
   - **Add .gitignore**: None (we already have one)
   - **Add README**: No (we have one)
4. Click **Create repository**

### Step 2: Get Repository URL

After creating, GitHub will show you commands. Copy the HTTPS URL:
```
https://github.com/YOUR_USERNAME/tao-device-controller.git
```

### Step 3: Push to GitHub

Run these commands in your project directory:

```bash
# Add the remote repository
git remote add origin https://github.com/YOUR_USERNAME/tao-device-controller.git

# Verify remote was added
git remote -v

# Add all files
git add .

# Commit with message
git commit -m "Initial commit: TAO Device Controller - complete IoT management system"

# Push to GitHub (replace main if you use different branch)
git branch -M main
git push -u origin main
```

**Done!** Your project is now on GitHub! 🎉

---

## 📝 Detailed Instructions

### Using HTTPS (Username + Token)

**Step 1: Generate Personal Access Token**

1. Go to GitHub → Settings → Developer settings → Personal access tokens
2. Click **Generate new token (classic)**
3. Set name: `TAO-Device-Controller`
4. Select scopes:
   - `repo` (full control of private repositories)
   - `public_repo` (access to public repositories)
5. Click **Generate token**
6. **Copy the token** (you won't see it again!)

**Step 2: Configure Git**

```bash
# Set your GitHub username
git config --global user.name "Your Name"

# Set your GitHub email
git config --global user.email "your.email@github.com"
```

**Step 3: Push to GitHub**

```bash
git remote add origin https://github.com/YOUR_USERNAME/tao-device-controller.git
git push -u origin main
```

When prompted for password, use your Personal Access Token.

### Using SSH (Recommended)

**Step 1: Generate SSH Key**

```bash
# Generate new SSH key
ssh-keygen -t ed25519 -C "your.email@github.com"

# When prompted, press Enter for default location
# Enter passphrase (optional but recommended)

# Start SSH agent
eval "$(ssh-agent -s)"

# Add key to agent
ssh-add ~/.ssh/id_ed25519
```

**Step 2: Add SSH Key to GitHub**

1. Copy SSH public key:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
2. Go to GitHub → Settings → SSH and GPG keys
3. Click **New SSH key**
4. Paste your key
5. Click **Add SSH key**

**Step 3: Push to GitHub**

```bash
git remote add origin git@github.com:YOUR_USERNAME/tao-device-controller.git
git push -u origin main
```

---

## 🔄 Daily Git Workflow

### Making Changes

```bash
# Check status
git status

# Add changes
git add .

# Commit changes
git commit -m "Add feature: [brief description]"

# Push to GitHub
git push
```

### Good Commit Messages

```
Feature: Add Vietnamese localization to Flutter app
Fix: Resolve device connection timeout issue
Docs: Update deployment checklist
Refactor: Simplify device control logic
```

---

## 📂 Repository Structure on GitHub

```
tao-device-controller/
├── backend/                 # Node.js server
│   ├── server.js
│   ├── controllers/
│   ├── services/
│   └── package.json
├── flutter/                 # Flutter mobile app
│   ├── lib/
│   ├── pubspec.yaml
│   └── ...
├── arduino/                 # Arduino firmware
│   ├── DeviceController.ino
│   └── README.md
├── README.md
├── SETUP_GUIDE.md
├── DEPLOYMENT_CHECKLIST.md
├── GITHUB_SETUP_GUIDE.md
└── .gitignore
```

---

## 🌿 Branching Strategy

### Main Branches

```bash
# main - production-ready code
# develop - development branch

# Create develop branch
git branch develop
git push -u origin develop
```

### Feature Branches

```bash
# Create feature branch
git checkout -b feature/device-scheduling

# Make changes
git add .
git commit -m "Add device scheduling feature"

# Push to GitHub
git push -u origin feature/device-scheduling

# Create Pull Request on GitHub
# After review, merge to develop, then to main
```

---

## 🔐 Security & Best Practices

### .gitignore Already Configured

✓ Excludes `.env` files (secrets)
✓ Excludes `node_modules/`
✓ Excludes Flutter build artifacts
✓ Excludes Arduino build files
✓ Excludes IDE configurations

### Never Commit

- `.env` files with API keys
- `node_modules/` directories
- Build artifacts
- Personal configuration files
- Credentials or secrets

### If You Accidentally Committed Secrets

```bash
# Remove file from history
git rm --cached .env

# Add to .gitignore
echo ".env" >> .gitignore

# Commit fix
git commit -m "Remove .env file and add to gitignore"

# Force push (only if not shared!)
git push --force-with-lease
```

---

## 📦 GitHub Actions (Optional)

Create `.github/workflows/test.yml` for CI/CD:

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '18'
      - name: Install dependencies
        run: cd backend && npm install
      - name: Run tests
        run: cd backend && npm test
```

---

## 🐛 Troubleshooting

### Error: "fatal: remote origin already exists"

```bash
# Remove existing remote
git remote remove origin

# Add new remote
git remote add origin https://github.com/YOUR_USERNAME/tao-device-controller.git
```

### Error: "Permission denied (publickey)"

```bash
# Check SSH connection
ssh -T git@github.com

# If fails, regenerate SSH key and add to GitHub
ssh-keygen -t ed25519 -C "your.email@github.com"
```

### Error: "Failed to push some refs"

```bash
# Pull latest changes
git pull origin main

# Resolve conflicts if any
# Then push again
git push origin main
```

### Large File Error

```bash
# Check file sizes
find . -size +100M

# Remove large files
git rm --cached large_file.bin

# Add to .gitignore
echo "large_file.bin" >> .gitignore
```

---

## 📊 Monitor Repository

After pushing, you can:

1. **Track Issues**
   - Go to GitHub repository
   - Click Issues tab
   - Create issues for bugs/features

2. **Track Progress**
   - Use Projects board
   - Organize tasks
   - Track milestones

3. **Documentation**
   - Update README.md
   - Add wiki pages
   - Keep docs in sync

---

## 🔗 Useful GitHub Links

- [GitHub Documentation](https://docs.github.com)
- [Git Documentation](https://git-scm.com/doc)
- [GitHub REST API](https://docs.github.com/en/rest)
- [GitHub CLI](https://cli.github.com/)

---

## 📚 Next Steps

1. ✓ Create GitHub repository
2. ✓ Push initial commit
3. Create `/docs` folder for additional documentation
4. Set up GitHub Pages for project website
5. Configure GitHub Actions for CI/CD
6. Add collaborators if working in team
7. Set up branch protection rules

---

## 🎓 Additional Resources

### Learn Git

```bash
# Initialize local repository (already done)
git init

# Clone a repository
git clone https://github.com/user/repo.git

# View commit history
git log --oneline

# View changes
git diff

# Undo changes
git restore file.txt
```

### GitHub Features to Explore

- **Releases** - Tag versions of your code
- **Discussions** - Community support
- **Wiki** - Project documentation
- **Pages** - Host static website
- **Actions** - CI/CD automation
- **Security** - Dependency scanning

---

## 💡 Tips

1. **Commit Often**: Small, focused commits are easier to review
2. **Write Good Messages**: Help future you understand why changes were made
3. **Pull Before Push**: Always sync with latest changes
4. **Review Before Committing**: Use `git diff` to review changes
5. **Create Branches**: Keep main stable, features in branches

---

## ✅ Verification Checklist

After pushing to GitHub, verify:

- [ ] Repository is visible on GitHub
- [ ] All files are present (not ignored)
- [ ] No .env files or secrets are visible
- [ ] README.md displays correctly
- [ ] Documentation is readable
- [ ] Commit history looks clean
- [ ] No large files (>100MB)

---

## 📞 Support

If you encounter issues:

1. Check GitHub's help documentation
2. Search existing GitHub issues
3. Create a new issue on your repository
4. Ask on Stack Overflow with `github` tag

---

**Happy coding!** Your TAO Device Controller is now on GitHub! 🚀


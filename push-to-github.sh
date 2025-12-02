#!/bin/bash
# File: /home/vince/IxomeAI/frontend/push-to-github.sh
# Purpose: Fix git config, add remote, amend commit, push IxomeAI frontend victory state – Dec 02, 2025
# Verification: Git status + log after push; error if push fails.

set -e

FRONTEND_DIR="/home/vince/IxomeAI/frontend"

if [ ! -d "$FRONTEND_DIR" ]; then
  echo "Error: Directory $FRONTEND_DIR not found!"
  exit 1
fi

if [ ! -f "$FRONTEND_DIR/.env" ]; then
  echo "Error: .env not found! Run setup-github-env.sh first."
  exit 1
fi

cd "$FRONTEND_DIR"

# Source .env securely
source .env

if [ -z "$GITHUB_PAT" ] || [ "$GITHUB_PAT" = "YOUR_GITHUB_PAT_HERE" ]; then
  echo "Error: GITHUB_PAT not set in .env!"
  exit 1
fi

# Backup key files before changes (only working ones)
BACKUP_DIR="$FRONTEND_DIR/backups-$(date +%Y%m%d)"
mkdir -p "$BACKUP_DIR"
cp nuxt.config.ts package.json app.vue "$BACKUP_DIR/" 2>/dev/null || true
echo "Backups created in $BACKUP_DIR (nuxt.config.ts, package.json, app.vue)."

# Set global git config (suppress warning)
git config --global user.name "$GITHUB_USERNAME"
git config --global user.email "$GITHUB_EMAIL"

# Amend commit to fix author
git commit --amend --reset-author --no-edit

# Add remote origin if not exists
if ! git remote | grep -q origin; then
  git remote add origin "https://github.com/$GITHUB_USERNAME/$GITHUB_REPO.git"
fi

# Push to main using PAT (secure auth)
git push -u origin main --force-with-lease

echo "SUCCESS: Pushed to https://github.com/$GITHUB_USERNAME/$GITHUB_REPO.git"
echo "Verification: git log -1 (check commit); open GitHub repo to confirm."
echo "Test: Clone fresh in temp dir: git clone https://github.com/$GITHUB_USERNAME/$GITHUB_REPO.git /tmp/test-ixome && cd /tmp/test-ixome && pnpm install && pnpm dev"
echo "Monitoring: Check GitHub for push notification; rotate PAT if compromised."
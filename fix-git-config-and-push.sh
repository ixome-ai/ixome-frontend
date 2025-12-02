#!/bin/bash
# File: /home/vince/IxomeAI/frontend/fix-git-config-and-push.sh
# Purpose: Fix git user config, amend commit with proper author, add remote with org, push to ixome-ai/ixome-frontend using bronn2120 PAT – Dec 02, 2025
# Verification: Git config list + log after push; error if push fails.

set -e

FRONTEND_DIR="/home/vince/IxomeAI/frontend"

if [ ! -d "$FRONTEND_DIR" ]; then
  echo "Error: Directory $FRONTEND_DIR not found!"
  exit 1
fi

if [ ! -f "$FRONTEND_DIR/.env" ]; then
  echo "Error: .env not found! Run ensure-frontend-env.sh first."
  exit 1
fi

cd "$FRONTEND_DIR"

# Source .env securely
source .env

if [ -z "$GITHUB_PAT" ]; then
  echo "Error: GITHUB_PAT not set in .env!"
  exit 1
fi

if [ -z "$GITHUB_USERNAME" ] || [ -z "$GITHUB_EMAIL" ]; then
  echo "Error: GITHUB_USERNAME or GITHUB_EMAIL not set in .env!"
  exit 1
fi

# Backup key files before changes
BACKUP_DIR="$FRONTEND_DIR/backups-$(date +%Y%m%d)"
mkdir -p "$BACKUP_DIR"
cp nuxt.config.ts package.json app.vue "$BACKUP_DIR/" 2>/dev/null || true
echo "Backups created in $BACKUP_DIR (nuxt.config.ts, package.json, app.vue)."

# Force set global git config before amend
git config --global user.name "$GITHUB_USERNAME"
git config --global user.email "$GITHUB_EMAIL"

# Amend commit to fix author (handle if no changes staged)
git add . || true  # Stage any unstaged if needed
git commit --amend --reset-author --no-edit || echo "No changes to amend; proceeding."

# Add/set remote origin with correct auth (personal user PAT for org repo)
git remote remove origin 2>/dev/null || true
git remote add origin "https://${GITHUB_USERNAME}:${GITHUB_PAT}@github.com/${GITHUB_ORG}/${GITHUB_REPO}.git"

# Push to main
git push -u origin main --force-with-lease

echo "SUCCESS: Pushed to https://github.com/${GITHUB_ORG}/${GITHUB_REPO}.git"
echo "Verification: git config --global --list | grep user (check name/email); git log -1 (check commit author); open GitHub repo to confirm files uploaded."
echo "Test: Clone fresh: git clone https://github.com/${GITHUB_ORG}/${GITHUB_REPO}.git /tmp/test-ixome && cd /tmp/test-ixome && pnpm install && pnpm dev"
echo "Monitoring: Check GitHub for push notification and access logs; rotate PAT every 90 days if compromised."
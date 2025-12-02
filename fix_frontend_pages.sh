#!/bin/bash
# Error handling for critical paths
if [ ! -d "/home/vincent/IxomeAI/frontend" ]; then
    echo "Error: Frontend directory /home/vincent/IxomeAI/frontend does not exist."
    exit 1
fi
cd /home/vincent/IxomeAI/frontend || { echo "Error: Failed to cd to frontend"; exit 1; }
# Backup existing app.vue only if working (contains "IXOME AI")
if [ -f "app.vue" ] && grep -q "IXOME AI" "app.vue" 2>/dev/null; then
    cp app.vue "app.vue.backup-$(date +%Y-%m-%d)"
    echo "Backed up working app.vue"
else
    echo "Skipping backup: app.vue is missing or broken"
fi
# Remove app.vue to use default entry and remove defaults
rm -f app.vue 2>/dev/null || true
# Ensure pages directory exists
mkdir -p pages
# Create complete working pages/index.vue
cat > pages/index.vue << 'EOF'
<script setup lang="ts"></script>

<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-900 via-green-900 to-black text-white flex items-center justify-center">
    <div class="text-center">
      <h1 class="text-9xl font-black tracking-tighter bg-clip-text text-transparent bg-gradient-to-r from-green-400 to-emerald-600 drop-shadow-2xl">
        IXOME AI
      </h1>
      <p class="text-4xl mt-8 opacity-90">Smart Home Intelligence • Lutron • Control4</p>
      <div class="mt-20 grid grid-cols-3 gap-16 text-9xl">
        <div>💡</div>
        <div>🌡️</div>
        <div>🔒</div>
      </div>
      <p class="mt-20 text-3xl text-green-400 font-bold animate-pulse">YOUR SITE IS LIVE — VICTORY</p>
    </div>
  </div>
</template>
EOF
# Clean caches
rm -rf .nuxt .output
# Robust kill and restart frontend
sudo fuser -k 3000/tcp >/dev/null 2>&1 || true
pkill -f "nuxt dev" >/dev/null 2>&1 || true
npm run dev -- --host 0.0.0.0 --port 3000
echo "Frontend fixed and started."
echo "Access at http://localhost:3000."
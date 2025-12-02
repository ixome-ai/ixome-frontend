#!/bin/bash
# Error handling for critical paths
if [ ! -d "/home/vincent/IxomeAI/frontend" ]; then
    echo "Error: Frontend directory /home/vincent/IxomeAI/frontend does not exist."
    exit 1
fi
cd /home/vincent/IxomeAI/frontend || { echo "Error: Failed to cd to frontend"; exit 1; }
# Backup existing nuxt.config.ts only if working (contains 'modules')
if [ -f "nuxt.config.ts" ] && grep -q "modules" "nuxt.config.ts" 2>/dev/null; then
    cp nuxt.config.ts "nuxt.config.ts.backup-$(date +%Y-%m-%d)"
    echo "Backed up working nuxt.config.ts"
else
    echo "Skipping backup: nuxt.config.ts is missing or broken"
fi
# Disable devtools in nuxt.config.ts to kill welcome page injection
cat > nuxt.config.ts << 'EOF'
export default defineNuxtConfig({
  compatibilityDate: "2025-11-28",
  devtools: { enabled: false },
  modules: [
    '@nuxt/ui', // This includes Tailwind v4 + icons + everything
  ]
})
EOF
# Clean caches
rm -rf .nuxt .output
# Robust kill and restart frontend
sudo fuser -k 3000/tcp >/dev/null 2>&1 || true
pkill -f "nuxt dev" >/dev/null 2>&1 || true
npm run dev -- --host 0.0.0.0 --port 3000
echo "Frontend fixed (welcome page disabled via devtools)."
echo "Access at http://localhost:3000."
echo "To view logs: tail -f /home/vincent/IxomeAI/frontend/.nuxt/dev-server.log"
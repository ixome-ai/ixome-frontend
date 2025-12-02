#!/bin/bash
# /home/vincent/IxomeAI/frontend/fix-frontend-pages-and-start.sh
# Complete script to fix truncated pages/index.vue, ensure login page exists, kill conflicting processes, and start Nuxt server with error checks and backups

set -e  # Exit on any error

BASE_DIR="/home/vincent/IxomeAI/frontend"
if [ ! -d "$BASE_DIR" ]; then echo "Error: Directory $BASE_DIR does not exist"; exit 1; fi
cd "$BASE_DIR"

# Backup existing index.vue if it exists and is non-empty (only backup if working, skip if truncated/broken)
if [ -f "pages/index.vue" ] && [ -s "pages/index.vue" ] && grep -q "Enter IxomeAI" "pages/index.vue" 2>/dev/null; then
  cp pages/index.vue "pages/index.vue.backup-$(date +%Y-%m-%d_%H-%M-%S)"
  echo "Backed up working pages/index.vue"
else
  echo "Skipping backup: pages/index.vue is truncated or broken"
fi

# Ensure pages and auth directories exist
if [ ! -d "pages" ]; then mkdir -p pages; fi
if [ ! -d "pages/auth" ]; then mkdir -p pages/auth; fi

# Create complete working pages/index.vue (full IxomeAI dashboard with Supabase error handling)
cat > pages/index.vue << 'EOF'
<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useSupabaseAuthClient } from '@nuxtjs/supabase'

const supabase = useSupabaseAuthClient()
const user = ref(null)
onMounted(async () => {
  try {
    const { data: { session } } = await supabase.auth.getSession()
    user.value = session?.user || null
  } catch (error) {
    console.error('Supabase user fetch error:', error)
  }
})
</script>

<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-900 via-green-900 to-black text-white">
    <UiContainer class="py-20">
      <div class="text-center">
        <h1 class="text-8xl font-black tracking-tighter mb-4 bg-clip-text text-transparent bg-gradient-to-r from-green-400 to-emerald-600">
          IXOME AI
        </h1>
        <p class="text-2xl opacity-90 mb-12">Smart Home Intelligence • Lutron • Control4</p>
        
        <div v-if="user" class="max-w-4xl mx-auto mt-20">
          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <UiCard class="bg-white/10 backdrop-blur border border-green-500/30">
              <UiCardHeader>
                <UiCardTitle class="text-green-400 text-3xl">Lights Control</UiCardTitle>
              </UiCardHeader>
              <UiCardContent class="text-6xl text-center py-12">
                💡
              </UiCardContent>
            </UiCard>
            
            <UiCard class="bg-white/10 backdrop-blur border border-green-500/30">
              <UiCardHeader>
                <UiCardTitle class="text-green-400 text-3xl">Climate</UiCardTitle>
              </UiCardHeader>
              <UiCardContent class="text-6xl text-center py-12">
                🌡️
              </UiCardContent>
            </UiCard>
            
            <UiCard class="bg-white/10 backdrop-blur border border-green-500/30">
              <UiCardHeader>
                <UiCardTitle class="text-green-400 text-3xl">Security</UiCardTitle>
              </UiCardHeader>
              <UiCardContent class="text-6xl text-center py-12">
                🔒
              </UiCardContent>
            </UiCard>
          </div>
        </div>
        
        <div v-else class="mt-20">
          <UiButton size="lg" class="text-2xl px-12 py-8" @click="navigateTo('/auth/login')">
            Enter IxomeAI
          </UiButton>
        </div>
      </div>
    </UiContainer>
  </div>
</template>
EOF

# Create complete working pages/auth/login.vue (simple login stub)
cat > pages/auth/login.vue << 'EOF'
<template>
  <div class="min-h-screen bg-black flex items-center justify-center">
    <div class="text-center">
      <h1 class="text-6xl font-black text-green-500 mb-8">IXOME AI</h1>
      <p class="text-xl text-gray-400">Authentication coming online...</p>
    </div>
  </div>
</template>

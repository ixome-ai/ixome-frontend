<script setup lang="ts">
import { onMounted } from 'vue';

// Initialize chat widget on mount
onMounted(() => {
  // Load Ixome chat script if not already present
  if (!document.getElementById('ixome-chat-script')) {
    const script = document.createElement('script');
    script.id = 'ixome-chat-script';
    script.src = '/js/ixome-chat.js'; // Adjust path if chat JS is in public/js
    script.async = true;
    document.body.appendChild(script);
  }
});
</script>

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
      <!-- Chat Widget Placeholder -->
      <div id="ixome-chat-widget" class="fixed bottom-4 right-4"></div>
    </div>
  </div>
</template>

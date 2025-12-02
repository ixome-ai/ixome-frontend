<template>
  <div class="min-h-screen bg-gray-50">
    <SiteHeader />
    <main class="max-w-6xl mx-auto px-6 py-16">
      <h1 class="text-5xl font-bold text-center mb-4">Simple, Transparent Pricing</h1>
      <p class="text-xl text-center text-gray-600 mb-12">Unlock the full power of your smart home.</p>

      <div class="grid md:grid-cols-3 gap-8">
        <!-- Free -->
        <div class="bg-white rounded-xl shadow-lg p-8">
          <h2 class="text-2xl font-bold mb-4">Free</h2>
          <p class="text-4xl font-bold mb-6">$0<span class="text-lg font-normal text-gray-500">/forever</span></p>
          <ul class="space-y-4 mb-8">
            <li>✓ Basic text troubleshooting</li>
            <li>✓ 10 queries per day</li>
            <li>✓ Community support</li>
          </ul>
          <button class="w-full bg-gray-300 text-gray-700 py-4 rounded-lg font-semibold" disabled>Current Plan</button>
        </div>

        <!-- Premium Monthly -->
        <div class="bg-gradient-to-br from-[#2E7D32] to-[#4CAF50] text-white rounded-xl shadow-2xl p-8 transform scale-105">
          <div class="bg-white/20 rounded-lg px-4 py-1 inline-block mb-4">Most Popular</div>
          <h2 class="text-3xl font-bold mb-4">Premium</h2>
          <p class="text-5xl font-bold mb-2">$14.99<span class="text-xl font-normal">/mo</span></p>
          <ul class="space-y-4 mb-8">
            <li>✓ Unlimited queries</li>
            <li>✓ Priority voice troubleshooter</li>
            <li>✓ Future scene builder</li>
            <li>✓ 24/7 priority fixes</li>
          </ul>
          <button @click="subscribe('monthly')" class="w-full bg-white text-[#2E7D32] py-4 rounded-lg font-bold text-lg hover:bg-gray-100 transition">Subscribe Monthly</button>
        </div>

        <!-- Lifetime -->
        <div class="bg-white rounded-xl shadow-lg p-8 border-2 border-[#2E7D32]">
          <h2 class="text-2xl font-bold mb-4">Lifetime</h2>
          <p class="text-4xl font-bold mb-6">$299<span class="text-lg font-normal text-gray-500"> one-time</span></p>
          <ul class="space-y-4 mb-8">
            <li>✓ Everything in Premium</li>
            <li>✓ No recurring billing</li>
            <li>✓ Forever updates</li>
          </ul>
          <button @click="subscribe('lifetime')" class="w-full bg-[#2E7D32] text-white py-4 rounded-lg font-bold text-lg hover:bg-[#1B5E20] transition">Buy Lifetime</button>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
const subscribe = async (type) => {
  const { data } = await $fetch('/api/create-session', {
    method: 'POST',
    body: { type }
  })
  window.location.href = data.url
}
</script>

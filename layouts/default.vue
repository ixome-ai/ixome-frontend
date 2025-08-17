<template>
  <div>
    <HeaderFive />
    <slot />
    <Footer />
  </div>
</template>

<script setup>
import HeaderFive from '~/layouts/HeaderFive.vue';
import Footer from '~/components/Footer.vue';
import { onMounted } from 'vue';

onMounted(() => {
  console.log('default.vue mounted - HeaderFive and Footer should render');
});
</script>

<style scoped>
/* No conflicting styles */
</style>
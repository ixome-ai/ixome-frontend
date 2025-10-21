<template>  
  <div class="dashboard">  
    <h1>Dashboard</h1>  
    <p>Tokens Used: {{ tokensUsed }} / {{ tokensLimit }}</p>  
  </div>  
</template>  
  
<script setup>  
import { ref } from 'vue';  
import { useAuthStore } from '~/stores/auth';  
  
const authStore = useAuthStore();  
const tokensUsed = ref(0);  
const tokensLimit = ref(100);  
  
// Fetch subscriber data  
const { data: subscriber } = await useFetch(`/api/subscriber-ids?filters[subscriber_id][$eq]=${authStore.user.id}`, {  
  baseURL: 'http://localhost:1337',  
  headers: { Authorization: `Bearer ${authStore.token}` }  
});  
  
if (subscriber.value?.data?.[0]?.attributes) {  
  tokensUsed.value = subscriber.value.data[0].attributes.tokens_used || 0;  
  tokensLimit.value = subscriber.value.data[0].attributes.tokens_limit || 100;  
}  
</script>  
  
<style>  
.dashboard { max-width: 600px; margin: 0 auto; padding: 20px; }  
</style>

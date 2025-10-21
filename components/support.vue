<!-- /home/vincent/ixome/ixome-frontend/website-frontend/frontend/components/support.vue -->  
<template>  
  <div class="support-container">  
    <h2>Support Chat</h2>  
    <div class="chat-box">  
      <div v-for="message in messages" :key="message.id" :class="['message', message.sender]">  
        <span>{{ message.text }}</span>  
        <small>{{ message.timestamp }}</small>  
      </div>  
    </div>  
    <div class="input-container">  
      <input v-model="newMessage" @keyup.enter="sendMessage" placeholder="Type your message..." aria-label="Chat input" />  
      <button @click="sendMessage" role="button" aria-label="Send message">Send</button>  
    </div>  
  </div>  
</template>  

<script setup>  
import { ref, onMounted } from 'vue';  
import axios from 'axios';  
import { useAuthStore } from '~/stores/auth';  

const authStore = useAuthStore();  
const messages = ref([]);  
const newMessage = ref('');  
const threadId = ref('session_' + (authStore.user?.id || 'default_user'));  

onMounted(() => {  
  if (!authStore.token) {  
    console.warn('No token; redirect to login');  
  }  
  messages.value.push({ id: Date.now(), sender: 'system', text: 'Hey there! I’m your IXome.ai chatbot—ready to help with a smile! 😄', timestamp: new Date().toLocaleTimeString() });  
});  

const sendMessage = async () => {  
  if (newMessage.value.trim()) {  
    const messageText = newMessage.value;  
    messages.value.push({ id: Date.now(), sender: 'user', text: messageText, timestamp: new Date().toLocaleTimeString() });  
    newMessage.value = '';  
    try {  
      const res = await axios.post('http://127.0.0.1:5003/agent/chat', {  
        input: messageText,  
        thread_id: threadId.value,  
        agent_type: 'chat',  
        user_id: authStore.user?.id || 'default_user',  
      }, {  
        headers: {  
          'Authorization': `Bearer ${authStore.token}`,  
          'Content-Type': 'application/json',  
        },  
      });  
      messages.value.push({ id: Date.now(), sender: 'bot', text: res.data.response, timestamp: new Date().toLocaleTimeString() });  
    } catch (err) {  
      console.error('API error:', err);  
      messages.value.push({ id: Date.now(), sender: 'system', text: 'Error: No active subscription or auth issue.', timestamp: new Date().toLocaleTimeString() });  
    }  
  }  
};  
</script>  

<style scoped>  
.support-container {  
  max-width: 600px;  
  margin: 20px auto;  
  padding: 20px;  
  border: 1px solid #ccc;  
  border-radius: 8px;  
}  
.chat-box {  
  max-height: 400px;  
  overflow-y: auto;  
  margin-bottom: 20px;  
  padding: 10px;  
  background: #f9f9f9;  
  border-radius: 8px;  
}  
.message {  
  margin: 10px 0;  
  padding: 10px;  
  border-radius: 5px;  
}  
.message.user {  
  background: #007bff;  
  color: white;  
  text-align: right;  
}  
.message.system, .message.bot {  
  background: #e9ecef;  
  color: black;  
}  
.message small {  
  display: block;  
  font-size: 0.8rem;  
  color: #666;  
}  
.input-container {  
  display: flex;  
  gap: 10px;  
}  
input {  
  flex: 1;  
  padding: 10px;  
  border: 1px solid #ccc;  
  border-radius: 5px;  
}  
button {  
  padding: 10px 20px;  
  background: #007bff;  
  color: white;  
  border: none;  
  border-radius: 5px;  
  cursor: pointer;  
}  
button:hover {  
  background: #0056b3;  
}  
</style>  
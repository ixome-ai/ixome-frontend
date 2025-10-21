<template>
  <div class="support-container">
    <h2>Support Chat</h2>
    <div v-if="isAuthenticated">
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
    <div v-else>
      Please login to use chat.
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import axios from 'axios';

const isAuthenticated = computed(() => !!localStorage.getItem('jwt'));
const messages = ref([]);
const newMessage = ref('');
const token = ref(localStorage.getItem('jwt') || '');
const threadId = ref('session_' + Date.now());

onMounted(() => {
  if (isAuthenticated.value) {
    messages.value.push({ id: Date.now(), sender: 'system', text: 'Hey there! I’m your Ixome.ai chatbot—ready to help with a smile! 😄', timestamp: new Date().toLocaleTimeString() });
  }
});

const sendMessage = async () => {
  if (newMessage.value.trim()) {
    const messageText = newMessage.value;
    messages.value.push({ id: Date.now(), sender: 'user', text: messageText, timestamp: new Date().toLocaleTimeString() });
    newMessage.value = '';

    try {
      const res = await axios.post('http://localhost:5003/agent/chat', {
        input: messageText,
        thread_id: threadId.value
      }, {
        headers: {
          'Authorization': `Bearer ${token.value}`,
          'Content-Type': 'application/json',
        },
      });
      messages.value.push({ id: Date.now(), sender: 'bot', text: res.data.response, timestamp: new Date().toLocaleTimeString() });
    } catch (err) {
      console.error('API error:', err);
      messages.value.push({ id: Date.now(), sender: 'system', text: 'Error sending message.', timestamp: new Date().toLocaleTimeString() });
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
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
      <input v-model="newMessage" @keyup.enter="sendMessage" placeholder="Type your message..." />
      <button @click="sendMessage">Send</button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import { io } from 'socket.io-client';

const messages = ref([]);
const newMessage = ref('');
const socket = ref(null);
const userId = ref(localStorage.getItem('user_id') || 'unknown');

onMounted(() => {
  socket.value = io('http://127.0.0.1:5003');
  socket.value.on('connect', () => {
    console.log('Connected to Socket.IO server');
    messages.value.push({ id: Date.now(), sender: 'system', text: 'Hey there! I’m your IXome.ai chatbot—ready to help with a smile! 😄', timestamp: new Date().toLocaleTimeString() });
  });
  socket.value.on('message', (data) => {
    console.log('Received SocketIO message:', data);
    messages.value.push({ id: Date.now(), sender: data.sender, text: data.text, timestamp: new Date().toLocaleTimeString() });
  });
});

onUnmounted(() => {
  if (socket.value) {
    socket.value.disconnect();
    console.log('Disconnecting SocketIO');
  }
});

const sendMessage = () => {
  if (newMessage.value.trim()) {
    const messageData = { message: newMessage.value, user_id: userId.value };
    console.log('Sending message:', messageData);
    socket.value.emit('message', messageData);
    messages.value.push({ id: Date.now(), sender: 'user', text: newMessage.value, timestamp: new Date().toLocaleTimeString() });
    newMessage.value = '';
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

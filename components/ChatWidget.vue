<template>
  <div>
    <!-- Floating Chat Button -->
    <NuxtLink
      v-if="showChatButton"
      to="/support"
      class="floating-chat-button"
      role="button"
      aria-label="Open support chat with ixome.ai"
    >
      <span>Chat with Us</span>
    </NuxtLink>

    <!-- Chat Widget (visible on /support) -->
    <div v-if="isSupportPage" class="chat-widget">
      <div v-if="!token" class="login-form">
        <input v-model="username" type="text" placeholder="Username" required>
        <input v-model="password" type="password" placeholder="Password" required>
        <button @click="login">Login</button>
      </div>
      <div v-else class="chat-interface">
        <div class="messages">
          <div v-for="(msg, index) in messages" :key="index" :class="{ 'sent': msg.sent, 'received': !msg.sent }">
            {{ msg.text }}
          </div>
        </div>
        <input v-model="query" type="text" placeholder="Quick question?" @keyup.enter="sendQuery">
        <button @click="sendQuery">Ask</button>
      </div>
      <p v-if="response">{{ response }}</p>
    </div>
  </div>
</template>

<script setup>
import { NuxtLink } from '#components';
import { ref, computed, onMounted, onUnmounted } from 'vue';
import { useRoute } from 'vue-router';
import { io } from 'socket.io-client';

const route = useRoute();
const showChatButton = computed(() => route.path !== '/support');
const isSupportPage = computed(() => route.path === '/support');

const username = ref('');
const password = ref('');
const query = ref('');
const response = ref('');
const token = ref('');
const messages = ref([]);
const socket = ref(null);

onMounted(() => {
  token.value = localStorage.getItem('token') || '';
  if (isSupportPage.value && token.value) {
    const userId = localStorage.getItem('user_id') || 'unknown';
    socket.value = io('http://127.0.0.1:5003', {
      auth: { token: token.value, user_id: userId },
    });

    socket.value.on('connect', () => {
      console.log('Connected to Socket.IO server');
      response.value = 'Connected to support chat!';
    });

    socket.value.on('message', (msg) => {
      messages.value.push({ text: typeof msg === 'string' ? msg : msg.text || msg.message || 'No response', sent: false });
    });

    socket.value.on('connect_error', (err) => {
      console.error('Socket connection error:', err);
      response.value = 'Connection error: ' + err.message;
    });
  }
});

onUnmounted(() => {
  if (socket.value) {
    socket.value.disconnect();
  }
});

const login = async () => {
  try {
    const res = await fetch('http://127.0.0.1:1337/api/auth/local', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ identifier: username.value, password: password.value }),
    });
    const data = await res.json();
    if (res.ok && data.jwt) {
      token.value = data.jwt;
      localStorage.setItem('token', data.jwt);
      localStorage.setItem('user_id', data.user.username);
      console.log('Login successful, JWT stored:', data.jwt);
      response.value = 'Login successful! You can now use the chat.';
      // Reload to connect socket
      location.reload();
    } else {
      response.value = data.error?.message || 'Login failed';
    }
  } catch (e) {
    response.value = 'Error logging in: ' + e.message;
  }
};

const sendQuery = () => {
  if (!query.value || !socket.value) {
    response.value = 'Please enter a message or ensure you are connected.';
    return;
  }
  const userId = localStorage.getItem('user_id') || 'unknown';
  socket.value.emit('message', { message: query.value, user_id: userId });
  messages.value.push({ text: query.value, sent: true });
  query.value = '';
};
</script>

<style scoped>
.floating-chat-button {
  position: fixed;
  bottom: 20px;
  right: 20px;
  background-color: #44ce6f;
  color: white;
  padding: 12px 24px;
  border-radius: 50px;
  text-decoration: none;
  box-shadow: 0 6px 12px rgba(68, 206, 111, 0.3);
  z-index: 1000;
  font-size: 1.1rem;
  font-family: 'Poppins', sans-serif;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;
}
.floating-chat-button:hover {
  background-color: #0e314c;
  transform: translateY(-2px);
}
.floating-chat-button:focus {
  outline: 3px solid #0e314c;
  outline-offset: 2px;
  background-color: #0e314c;
}
.floating-chat-button span {
  display: inline-block;
  text-align: center;
  font-weight: 500;
}
.chat-widget {
  position: fixed;
  bottom: 80px;
  right: 20px;
  background: white;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 8px;
  z-index: 999;
}
.login-form {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.login-form input {
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
}
.login-form button {
  padding: 8px;
  background-color: #44ce6f;
  color: white;
  border: none;
  border-radius: 4px;
}
.chat-interface {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.messages {
  max-height: 200px;
  overflow-y: auto;
  border: 1px solid #ddd;
  padding: 10px;
  border-radius: 4px;
}
.sent {
  text-align: right;
  color: blue;
}
.received {
  text-align: left;
  color: black;
}
.chat-interface input {
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
}
.chat-interface button {
  padding: 8px;
  background-color: #44ce6f;
  color: white;
  border: none;
  border-radius: 4px;
}
@media (max-width: 768px) {
  .floating-chat-button {
    bottom: 10px;
    right: 10px;
    padding: 10px 18px;
    font-size: 1rem;
  }
}
</style>
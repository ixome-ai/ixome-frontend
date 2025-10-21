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
      <div v-if="!authStore.token" class="login-form">
        <input v-model="username" type="text" placeholder="Username or Email" required>
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
import { useAuthStore } from '~/stores/auth';
const route = useRoute();
const showChatButton = computed(() => route.path !== '/support');
const isSupportPage = computed(() => route.path === '/support');
const username = ref('');
const password = ref('');
const query = ref('');
const response = ref('');
const messages = ref([]);
const authStore = useAuthStore();
onMounted(async () => {
  if (isSupportPage.value && authStore.token) {
    console.log('Using stored JWT for chat');
    if (!authStore.user) {
      try {
        const res = await fetch('http://localhost:1337/api/users/me', {
          headers: { 'Authorization': `Bearer ${authStore.token}` }
        });
        if (res.ok) {
          const data = await res.json();
          authStore.setUser(data);
          console.log('User loaded from /me:', data);
        } else {
          console.error('Failed to load user from /me');
        }
      } catch (e) {
        console.error('Error loading user:', e);
      }
    }
  }
});
const login = async () => {
  try {
    const res = await fetch('http://localhost:1337/api/auth/local', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ identifier: username.value, password: password.value }),
    });
    const data = await res.json();
    if (res.ok && data.jwt) {
      authStore.setAuth(data.jwt, data.user);
      console.log('Login successful, JWT stored:', data.jwt);
      response.value = 'Login successful! You can now use the chat.';
      // Reload to apply auth
      location.reload();
    } else {
      response.value = data.error?.message || 'Login failed';
    }
  } catch (e) {
    response.value = 'Error logging in: ' + e.message;
  }
};
const sendQuery = async () => {
  if (!query.value) {
    response.value = 'Please enter a message.';
    return;
  }
  const token = authStore.token;
  if (!token) {
    response.value = 'No JWT token available. Please login.';
    return;
  }
  messages.value.push({ text: query.value, sent: true });
  try {
    const res = await fetch('http://localhost:5003/agent/chat', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify({
        input: query.value,
        thread_id: 'test1' // Placeholder
      })
    });
    const data = await res.json();
    if (res.ok) {
      messages.value.push({ text: data.response, sent: false });
    } else {
      messages.value.push({ text: 'Error: ' + (data.error || 'Unknown error'), sent: false });
    }
  } catch (e) {
    messages.value.push({ text: 'Error sending message: ' + e.message, sent: false });
  }
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
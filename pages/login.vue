<template>  
  <div class="login-page">  
    <div class="container">  
      <h2>Login to Ixome</h2>  
      <form @submit.prevent="submitLogin">  
        <div class="form-group">  
          <label for="identifier">Email or Username</label>  
          <input id="identifier" v-model="identifier" type="text" required />  
        </div>  
        <div class="form-group">  
          <label for="password">Password</label>  
          <input id="password" v-model="password" type="password" required />  
        </div>  
        <button type="submit">Login</button>  
      </form>  
      <p v-if="errorMessage" class="error">{{ errorMessage }}</p>  
    </div>  
  </div>  
</template>  

<script setup>  
import { ref } from 'vue';  
import { useRouter } from 'vue-router';  

const identifier = ref('test@ixome.ai');  
const password = ref('Test212!');  
const errorMessage = ref('');  
const router = useRouter();  

const submitLogin = async () => {  
  try {  
    const response = await fetch('http://127.0.0.1:1337/api/auth/local', {  
      method: 'POST',  
      headers: { 'Content-Type': 'application/json' },  
      body: JSON.stringify({ identifier: identifier.value, password: password.value })  
    });  
    const data = await response.json();  
    if (response.ok && data.jwt) {  
      localStorage.setItem('jwt', data.jwt);  
      localStorage.setItem('user_id', data.user.email);  
      router.push('/support');  
    } else {  
      errorMessage.value = data.error?.message || 'Login failed';  
    }  
  } catch (error) {  
    errorMessage.value = 'Login error: ' + error.message;  
  }  
};  
</script>  

<style scoped>  
.login-page {  
  display: flex;  
  justify-content: center;  
  align-items: center;  
  height: 100vh;  
  background-color: #f7fafd;  
}  
.container {  
  background: white;  
  padding: 40px;  
  border-radius: 8px;  
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);  
  width: 100%;  
  max-width: 400px;  
}  
h2 {  
  text-align: center;  
  margin-bottom: 20px;  
}  
.form-group {  
  margin-bottom: 15px;  
}  
label {  
  display: block;  
  margin-bottom: 5px;  
}  
input {  
  width: 100%;  
  padding: 10px;  
  border: 1px solid #ddd;  
  border-radius: 4px;  
}  
button {  
  width: 100%;  
  padding: 10px;  
  background-color: #007bff;  
  color: white;  
  border: none;  
  border-radius: 4px;  
  cursor: pointer;  
}  
button:hover {  
  background-color: #0056b3;  
}  
.error {  
  color: red;  
  text-align: center;  
  margin-top: 10px;  
}  
</style>  
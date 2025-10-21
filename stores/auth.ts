import { defineStore } from 'pinia';  

export const useAuthStore = defineStore('auth', {  
  state: () => ({  
    token: '',  
    user: null,  
  }),  
  actions: {  
    setAuth(payload) {  
      this.token = payload.token;  
      this.user = payload.user;  
      localStorage.setItem('jwt', payload.token);  
      localStorage.setItem('user_id', payload.user.username);  
    },  
    logout() {  
      this.token = '';  
      this.user = null;  
      localStorage.removeItem('jwt');  
      localStorage.removeItem('user_id');  
    },  
  },  
});  
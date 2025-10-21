export default defineNuxtRouteMiddleware((to, from) => {  
  const authStore = useAuthStore();  
  if (!authStore.token && to.path !== '/login') {  
    return navigateTo('/login');  
  }  
});  
nano nuxt.config.ts  
# Add to export default defineNuxtConfig({ ... }):  
routeRules: {  
  '/support/**': { middleware: 'auth' },  
  '/dashboard/**': { middleware: 'auth' }  
}

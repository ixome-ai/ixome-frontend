export default defineNuxtConfig({
  compatibilityDate: '2025-08-21',
  modules: ['@nuxtjs/tailwindcss', '@nuxtjs/color-mode', 'nuxt-socket-io'],
  socketio: {
    name: 'ixome',
    server: 'http://127.0.0.1:5003'
  },
  tailwindcss: {
    cssPath: '~/assets/css/tailwind.css',
    configPath: 'tailwind.config.js',
    exposeConfig: false,
    viewer: true,
  },
  colorMode: {
    preference: 'system',
    fallback: 'light',
    hid: 'nuxt-color-mode-script',
    globalName: '__NUXT_COLOR_MODE__',
    componentName: 'ColorScheme',
    classPrefix: '',
    classSuffix: '-mode',
    storageKey: 'nuxt-color-mode',
  },
  css: ['~/assets/css/tailwind.css'],
  build: {
    transpile: ['gsap', '@fortawesome/vue-fontawesome', 'bootstrap'],
  },
  runtimeConfig: {
    public: {
      strapiUrl: 'http://127.0.0.1:1337',
      backendUrl: 'http://127.0.0.1:5003',
    },
  },
  app: {
    head: {
      title: 'IXome.ai - Smart Home Automation',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { hid: 'description', name: 'description', content: 'IXome.ai provides AI-driven smart home solutions with Control4 and Lutron support.' },
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
        { rel: 'stylesheet', href: 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css' },
        { rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css' },
        { rel: 'stylesheet', href: 'https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' },
        { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap' },
      ],
      script: [
        { src: 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js', body: true, defer: true },
      ],
    },
  },
  ssr: false,
  errorHandler: '~/error.vue',
  vite: {
    server: {
      hmr: false,
    },
    logLevel: 'info',
    optimizeDeps: {
      exclude: ['path', 'fs', 'url', 'source-map-js']
    },
  },
  render: {
    static: true,
    bundleRenderer: {
      shouldPreload: (file, type) => false,
    },
  },
  devtools: {
    enabled: false,
    timeline: false,
  },
})
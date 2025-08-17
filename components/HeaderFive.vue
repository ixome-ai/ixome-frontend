<template>
  <header class="header-five">
    <nav class="navbar navbar-expand-lg navbar-light bg-white">
      <div class="container">
        <a class="navbar-brand" href="/">
          <img src="~/assets/images/logo.png" alt="IXome.ai Logo" class="logo">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ms-auto">
            <li class="nav-item">
              <NuxtLink class="nav-link" to="/support">Support</NuxtLink>
            </li>
            <li class="nav-item">
              <NuxtLink class="nav-link" to="/account">Account</NuxtLink>
            </li>
            <li class="nav-item">
              <NuxtLink class="nav-link" to="/blog">Blog</NuxtLink>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  </header>
</template>

<script setup>
import { NuxtLink } from '#components';
onMounted(() => {
  console.log('HeaderFive.vue mounted');
  const navbar = document.querySelector('.navbar-collapse');
  if (navbar) {
    console.log('Navbar elements found, initializing Bootstrap collapse');
  }
});
</script>

<style scoped>
.header-five {
  background-color: #ffffff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
.logo {
  height: 50px;
}
.nav-link {
  font-size: 1rem;
  font-weight: 500;
  color: #333;
  padding: 1rem;
}
.nav-link:hover {
  color: #007bff;
}
</style>
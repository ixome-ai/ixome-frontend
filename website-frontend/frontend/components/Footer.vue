<template>
  <div class="footer-area bg-f7fafd">
    <div class="container mx-auto px-4">
      <div v-if="footerData" class="row">
        <div class="col-lg-4 col-md-6">
          <h3>{{ footerData.title || 'Main Footer' }}</h3>
          <div v-for="block in footerData.footer || []" :key="block.type">
            <p v-for="child in block.children" :key="child.text">{{ child.text }}</p>
          </div>
        </div>
        <div class="col-lg-4 col-md-6">
          <h3>{{ footerData.titleTwo || 'Contact Us' }}</h3>
          <ul class="list-none">
            <li v-for="item in footerData.companyLists || fallbackCompanyLists" :key="item.title">
              <a :href="item.link" class="text-blue-500 hover:text-green-500">{{ item.title }}</a>
            </li>
          </ul>
          <ul class="list-none">
            <li v-for="item in footerData.supportLists || fallbackSupportLists" :key="item.title">
              <a :href="item.link" class="text-blue-500 hover:text-green-500">{{ item.title }}</a>
            </li>
          </ul>
        </div>
        <div class="col-lg-4 col-md-6">
          <h3>{{ footerData.titleThree || 'Contact' }}</h3>
          <p>{{ footerData.address || '123 Smart St, Tech City' }}</p>
          <p>Email: <a :href="`mailto:${footerData.email || 'support@ixome.ai'}`">{{ footerData.email || 'support@ixome.ai' }}</a></p>
          <p>Phone: <a :href="`tel:${footerData.phone || '555-123-4567'}`">{{ footerData.phone || '555-123-4567' }}</a></p>
          <ul class="list-none flex gap-4">
            <li v-for="social in footerData.socialLink || fallbackSocialLinks" :key="social.link">
              <a :href="social.link" target="_blank" :aria-label="social.title || 'Social Media'"><i :class="social.icon"></i></a>
            </li>
          </ul>
        </div>
        <div class="col-lg-12 col-md-12">
          <div class="copyright-area">
            <p>Copyright ©{{ currentYear }} IXome. All Rights Reserved</p>
          </div>
        </div>
      </div>
      <div v-else-if="error" class="text-center text-red-600">
        <p>Failed to load footer data: {{ error.message }}</p>
      </div>
      <div v-else class="text-center text-gray-600">
        <p>Loading footer data...</p>
      </div>
    </div>
    <img src="~/assets/img/map.png" class="map" alt="map" />
    <div class="shape1"><img src="~/assets/img/shape1.png" alt="shape" /></div>
    <div class="shape8 rotateme"><img src="~/assets/img/shape2.svg" alt="shape" /></div>
    <div :class="['go-top', { active: isTop }]" @click="scrollToTop()" role="button" aria-label="Scroll to top">
      <i class="fas fa-arrow-up"></i>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const isTop = ref(false);
const currentYear = ref(new Date().getFullYear());
const footerData = ref(null);
const error = ref(null);
const STRAPI_BASE_URL = 'http://127.0.0.1:1337';

const fallbackCompanyLists = [
  { title: 'IXome', link: 'ixome.ai' },
  { title: 'About', link: '/about' },
  { title: 'Services', link: '/services' }
];
const fallbackSupportLists = [
  { title: 'FAQ', link: '/faq' },
  { title: 'Support', link: '/support' },
  { title: 'Contact', link: '/contact' }
];
const fallbackSocialLinks = [
  { link: 'https://facebook.com', icon: 'fab fa-facebook', title: 'Facebook' },
  { link: 'https://twitter.com/ixome', icon: 'fab fa-twitter', title: 'Twitter' },
  { link: 'https://linkedin.com', icon: 'fab fa-linkedin-in', title: 'LinkedIn' },
  { link: 'https://instagram.com', icon: 'fab fa-instagram', title: 'Instagram' }
];

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: 'smooth' });
};

onMounted(async () => {
  window.addEventListener('scroll', () => {
    let scrollPos = window.scrollY;
    isTop.value = scrollPos >= 100;
  });

  try {
    const response = await fetch(`${STRAPI_BASE_URL}/api/footers?populate=*`);
    const responseData = await response.json();
    console.log('Raw footer response:', responseData);
    footerData.value = responseData.data[0]?.attributes || {};
    console.log('Footer data loaded:', footerData.value);
  } catch (err) {
    console.error('Footer fetch error:', err);
    error.value = err;
  }
});
</script>

<style scoped>
.footer-area {
  position: relative;
  z-index: 1;
  background-color: #f7fafd;
  padding: 80px 0;
}
.container {
  max-width: 1140px;
  margin: 0 auto;
}
.row {
  display: flex;
  flex-wrap: wrap;
}
.col-lg-4 {
  flex: 0 0 33.3333%;
  max-width: 33.3333%;
}
.col-md-6 {
  flex: 0 0 50%;
  max-width: 50%;
}
.footer-area h3 {
  font-size: 1.5rem;
  font-weight: 700;
  margin-bottom: 1rem;
  color: #333;
}
.footer-area p {
  font-size: 1rem;
  color: #666;
  margin-bottom: 0.5rem;
}
.footer-area ul {
  padding: 0;
  list-style: none;
}
.footer-area ul li {
  margin-bottom: 0.5rem;
}
.footer-area ul li a {
  color: #007bff;
  text-decoration: none;
  font-size: 1rem;
}
.footer-area ul li a:hover {
  color: #28a745;
}
.copyright-area {
  text-align: center;
  margin-top: 30px;
  border-top: 1px solid #e5e5e5;
  padding-top: 20px;
}
.copyright-area p {
  font-size: 14px;
  color: #333;
}
.map {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  z-index: -1;
}
.shape1, .shape8 {
  position: absolute;
}
.shape1 {
  bottom: 0;
  left: 0;
}
.shape8 {
  top: 0;
  right: 0;
}
.rotateme {
  animation: rotateme 24s linear infinite;
}
@keyframes rotateme {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}
.go-top {
  position: fixed;
  bottom: 20px;
  right: 20px;
  background-color: #007bff;
  color: #fff;
  padding: 10px 15px;
  border-radius: 50px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  z-index: 1000;
}
.go-top:hover {
  background-color: #0056b3;
}
.go-top.active {
  opacity: 1;
  visibility: visible;
}
@media (max-width: 768px) {
  .footer-area {
    padding: 40px 0;
  }
  .col-lg-4 {
    flex: 0 0 100%;
    max-width: 100%;
  }
  .col-md-6 {
    flex: 0 0 100%;
    max-width: 100%;
  }
  .footer-area h3 {
    font-size: 1.25rem;
  }
  .footer-area p {
    font-size: 0.9rem;
  }
}
</style>
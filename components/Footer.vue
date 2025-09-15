<template>
  <div class="footer-area bg-f7fafd">
    <div class="container">
      <div class="row" v-if="footer || error">
        <div class="col-lg-3 col-md-6 col-sm-6">
          <div class="single-footer-widget">
            <div class="logo">
              <NuxtLink to="/">
                <img v-if="footerLogoUrl" :src="footerLogoUrl" alt="ixome.ai logo" />
                <img v-else src="~/assets/img/logo.png" alt="ixome.ai default logo" />
              </NuxtLink>
            </div>
            <p>{{ footer?.shortDesc || 'Empowering smart homes with AI-driven solutions for Lutron and Control4.' }}</p>
          </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-6">
          <div class="single-footer-widget pl-5">
            <h3>{{ footer?.title || 'Company' }}</h3>
            <ul class="list">
              <li v-for="company in footer?.companyLists || fallbackCompanyLists" :key="company.id || company.title">
                <NuxtLink v-if="isInternalLink(company.link)" :to="mapInternalLink(company.link)" class="footer-link">{{ company.title }}</NuxtLink>
                <a v-else :href="company.link" target="_blank" class="footer-link">{{ company.title }}</a>
              </li>
            </ul>
          </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-6">
          <div class="single-footer-widget">
            <h3>{{ footer?.titleTwo || 'Support' }}</h3>
            <ul class="list">
              <li v-for="support in footer?.supportLists || fallbackSupportLists" :key="support.id || support.title">
                <NuxtLink v-if="isInternalLink(support.link)" :to="mapInternalLink(support.link)" class="footer-link">{{ support.title }}</NuxtLink>
                <a v-else :href="support.link" target="_blank" class="footer-link">{{ support.title }}</a>
              </li>
            </ul>
          </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-6">
          <div class="single-footer-widget">
            <h3>{{ footer?.titleThree || 'Contact' }}</h3>
            <ul class="footer-contact-info">
              <li><i class="fas fa-map-marker-alt"></i>{{ footer?.address || '123 Smart Home Ave, Tech City, USA' }}</li>
              <li><i class="fas fa-envelope"></i>Email: <a :href="`mailto:${footer?.email || 'support@ixome.ai'}`">{{ footer?.email || 'support@ixome.ai' }}</a></li>
              <li><i class="fas fa-phone"></i>Phone: <a :href="`tel:${footer?.phone || '+1-800-IXOME-AI'}`">{{ footer?.phone || '+1-800-IXOME-AI' }}</a></li>
            </ul>
            <ul class="social-links">
              <li v-for="social in footer?.socialLink || fallbackSocialLinks" :key="social.id || social.icon">
                <a :href="social.link" target="_blank" :aria-label="social.title || 'Social Media'"><i :class="social.icon || 'fab fa-facebook'"></i></a>
              </li>
            </ul>
          </div>
        </div>
        <div class="col-lg-12 col-md-12">
          <div class="copyright-area">
            <p>Copyright ©{{ currentYear }} IXome. All Rights Reserved</p>
          </div>
        </div>
      </div>
      <div v-else>
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
import { NuxtLink } from '#components';

const isTop = ref(false);
const currentYear = ref(new Date().getFullYear());
const footer = ref(null);
const footerLogoUrl = ref(null);
const error = ref(false);
const strapiUrl = useRuntimeConfig().public.strapiUrl;

const fallbackCompanyLists = [
  { title: 'IXome', link: '/' },
  { title: 'About', link: '/about' },
  { title: 'Services', link: '/services' }
];
const fallbackSupportLists = [
  { title: 'FAQ', link: '/faq' },
  { title: 'Support', link: '/support' },
  { title: 'Contact', link: '/contact' }
];
const fallbackSocialLinks = [
  { link: 'https://facebook.com/ixomeai', icon: 'fab fa-facebook', title: 'Facebook' },
  { link: 'https://twitter.com/ixomeai', icon: 'fab fa-twitter', title: 'Twitter' },
  { link: 'https://linkedin.com/company/ixomeai', icon: 'fab fa-linkedin-in', title: 'LinkedIn' },
  { link: 'https://instagram.com/ixomeai', icon: 'fab fa-instagram', title: 'Instagram' }
];

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: 'smooth' });
};

const isInternalLink = (link) => {
  return link && link.startsWith('/');
};

const mapInternalLink = (link) => {
  return link;
};

onMounted(async () => {
  window.addEventListener('scroll', () => {
    let scrollPos = window.scrollY;
    isTop.value = scrollPos >= 100;
  });

  try {
    const footerResponse = await fetch(`${strapiUrl}/api/footers?populate=*`);
    if (!footerResponse.ok) throw new Error('Fetch failed');
    const footerData = await footerResponse.json();
    footer.value = footerData.data[0]?.attributes || {};

    const relativeUrl = footer.value?.logo?.data?.attributes?.url || null;
    footerLogoUrl.value = relativeUrl ? `${strapiUrl}${relativeUrl}` : null;
  } catch (err) {
    console.error('Error fetching footer data:', err);
    error.value = true;
  }
});
</script>

<style scoped>
.footer-area {
  padding: 80px 0 40px;
  background-color: #f7fafd;
  position: relative;
  overflow: hidden;
}
.container {
  max-width: 1140px;
  margin: 0 auto;
  padding: 0 15px;
}
.row {
  display: flex;
  flex-wrap: wrap;
  margin: -15px;
}
.row > div {
  padding: 15px;
  box-sizing: border-box;
}
.single-footer-widget {
  margin-bottom: 30px;
}
.single-footer-widget .logo {
  margin-bottom: 20px;
}
.single-footer-widget .logo img {
  max-width: 150px;
  height: auto;
}
.single-footer-widget p {
  font-size: 14px;
  color: #666;
  line-height: 1.6;
}
.single-footer-widget h3 {
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 20px;
  color: #333;
}
.single-footer-widget ul.list {
  list-style: none;
  padding: 0;
  margin: 0;
}
.single-footer-widget ul.list li {
  margin-bottom: 10px;
}
.footer-link {
  text-decoration: none;
  color: #666;
  font-size: 14px;
  transition: color 0.3s ease;
}
.footer-link:hover {
  color: #007bff;
}
.footer-contact-info {
  list-style: none;
  padding: 0;
  margin: 0;
}
.footer-contact-info li {
  font-size: 14px;
  color: #666;
  margin-bottom: 10px;
  display: flex;
  align-items: center;
}
.footer-contact-info li i {
  margin-right: 10px;
  color: #007bff;
  font-size: 16px;
}
.social-links {
  list-style: none;
  padding: 0;
  margin: 20px 0 0;
  display: flex;
  gap: 15px;
}
.social-links li a {
  font-size: 18px;
  color: #666;
  transition: color 0.3s ease;
}
.social-links li a:hover {
  color: #007bff;
}
.copyright-area {
  text-align: center;
  margin-top: 40px;
  border-top: 1px solid #e5e5e5;
  padding-top: 20px;
}
.copyright-area p {
  font-size: 14px;
  color: #666;
}
.map {
  position: absolute;
  bottom: -50px;
  left: 0;
  width: 100%;
  opacity: 0.1;
  z-index: -1;
}
.shape1, .shape8 {
  position: absolute;
  z-index: -1;
}
.shape1 {
  bottom: 20px;
  left: 5%;
  max-width: 100px;
}
.shape8 {
  top: 20px;
  right: 5%;
  max-width: 100px;
}
.rotateme {
  animation: rotateme 24s linear infinite;
}
@keyframes rotateme {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}
.go-top {
  position: fixed;
  bottom: 30px;
  right: 30px;
  background-color: #007bff;
  color: #fff;
  padding: 12px 16px;
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.3s ease;
  z-index: 1000;
  opacity: 0;
  visibility: hidden;
}
.go-top:hover {
  background-color: #0056b3;
}
.go-top.active {
  opacity: 1;
  visibility: visible;
}
@media (max-width: 991px) {
  .row > div {
    flex: 0 0 50%;
    max-width: 50%;
  }
}
@media (max-width: 767px) {
  .row > div {
    flex: 0 0 100%;
    max-width: 100%;
  }
  .pl-5 {
    padding-left: 0 !important;
  }
}
</style>
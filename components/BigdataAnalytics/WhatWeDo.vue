<template>
  <div class="what-we-do-area ptb-80">
    <div class="container">
      <div class="section-title">
        <h2>What We Do</h2>
        <div class="bar"></div>
        <p>At IXome.ai, with 35 years of expertise, we empower users of home and business electronics to operate independently and securely, easing daily frustrations through AI-driven support for Control4, Lutron, and beyond.</p>
      </div>

      <div class="row">
        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="single-what-we-do-box">
            <div class="icon">
              <client-only>
                <font-awesome-icon :icon="['fas', 'life-ring']" class="circular-icon bg-purple-100 text-purple-600" />
              </client-only>
            </div>
            <h3><NuxtLink to="/services">Effortless Troubleshooting</NuxtLink></h3>
            <p>Resolve issues quickly with our AI chatbot, promoting independence and reducing stress for a seamless experience across your electronics setup.</p>
            <ul class="issues-list">
              <li>Lighting problems</li>
              <li>Whole-house audio -no sound</li>
              <li>Home theater no sound or white screen</li>
              <li>Network connectivity</li>
              <li>Phone not connecting</li>
              <li>Remote control/touch screen malfunctions</li>
            </ul>
            <NuxtLink to="/services" class="read-more-btn">
              <client-only>
                <font-awesome-icon :icon="['fas', 'arrow-right']" class="fa-icon" />
              </client-only> Read More
            </NuxtLink>
          </div>
        </div>

        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="single-what-we-do-box">
            <div class="icon">
              <client-only>
                <font-awesome-icon :icon="['fas', 'tools']" class="circular-icon bg-green-100 text-green-600" />
              </client-only>
            </div>
            <h3><NuxtLink to="/maintenance">Proactive Maintenance</NuxtLink></h3>
            <p>Automate updates, power cycles, and monitoring to prevent downtime and ensure optimal performance—we prioritize reliability for your peace of mind.</p>
            <NuxtLink to="/maintenance" class="link">Firmware Updates</NuxtLink>
            <NuxtLink to="/maintenance" class="link">Programming Updates</NuxtLink>
            <NuxtLink to="/maintenance" class="read-more-btn">
              <client-only>
                <font-awesome-icon :icon="['fas', 'arrow-right']" class="fa-icon" />
              </client-only> Read More
            </NuxtLink>
          </div>
        </div>

        <div class="col-lg-4 col-md-6 col-sm-6 offset-lg-0 offset-md-3 offset-sm-3">
          <div class="single-what-we-do-box">
            <div class="icon">
              <client-only>
                <font-awesome-icon :icon="['fas', 'users-cog']" class="circular-icon bg-blue-100 text-blue-600" />
              </client-only>
            </div>
            <h3><NuxtLink to="/community">Empowering Community</NuxtLink></h3>
            <p>Connect with users for shared insights, fostering a supportive network that enhances your electronics management journey.</p>
            <NuxtLink to="/community" class="link">Forums & Tips</NuxtLink>
            <NuxtLink to="/community" class="link">Collaborative Growth</NuxtLink>
            <NuxtLink to="/community" class="read-more-btn">
              <client-only>
                <font-awesome-icon :icon="['fas', 'arrow-right']" class="fa-icon" />
              </client-only> Read More
            </NuxtLink>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { faArrowRight, faLifeRing, faTools, faUsersCog } from '@fortawesome/free-solid-svg-icons';
import { library } from '@fortawesome/fontawesome-svg-core';
import { NuxtLink } from '#components';

library.add(faArrowRight, faLifeRing, faTools, faUsersCog);

export default {
  name: 'WhatWeDo',
  components: {
    FontAwesomeIcon,
    NuxtLink
  }
};
</script>

<style scoped>
.what-we-do-area {
  padding-top: 80px;
  padding-bottom: 80px;
}
.section-title {
  text-align: center;
  margin-bottom: 60px;
}
.section-title h2 {
  font-size: 36px;
  font-weight: 700;
  margin-bottom: 0;
}
.section-title .bar {
  height: 5px;
  width: 50px;
  background-color: #684df4;
  margin: 15px auto 20px;
  position: relative;
  border-radius: 30px;
}
.section-title .bar::before {
  content: '';
  position: absolute;
  left: 0;
  top: -2.5px;
  height: 10px;
  width: 10px;
  border-radius: 50px;
  background-color: #ffffff;
  border: 2px solid #684df4;
}
.section-title p {
  max-width: 600px;
  margin: 0 auto;
}
.single-what-we-do-box {
  margin-bottom: 30px;
  border-radius: 5px;
  box-shadow: 0 2px 48px 0 rgba(0, 0, 0, 0.08);
  transition: 0.6s;
  padding: 20px;
}
.single-what-we-do-box .icon {
  margin-bottom: 10px;
}
.circular-icon {
  display: inline-flex;
  justify-content: center;
  align-items: center;
  width: 80px;
  height: 80px;
  border-radius: 50%;
  font-size: 2rem;
  transition: all 0.3s ease;
}
.circular-icon:hover {
  transform: scale(1.1);
  box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
}
.single-what-we-do-box h3 {
  font-size: 22px;
  font-weight: 700;
  margin-bottom: 10px;
}
.single-what-we-do-box p {
  margin-bottom: 10px;
}
.issues-list {
  list-style-type: disc;
  padding-left: 20px;
  text-align: left;
  font-size: 14px;
  color: #5c5c5c;
  margin-bottom: 10px;
}
.issues-list li {
  margin-bottom: 5px;
}
.single-what-we-do-box .link {
  display: block;
  color: #684df4;
  margin: 5px 0;
}
.read-more-btn {
  display: inline-flex;
  align-items: center;
  font-size: 15px;
  font-weight: 600;
  color: #684df4;
  margin-top: 20px;
}
.read-more-btn .fa-icon {
  width: 20px;
  height: 20px;
  margin-right: 5px;
}
</style>
<template>
  <section class="services-area ptb-80 bg-f7fafd">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-4 col-md-6">
          <div class="single-services-box">
            <div class="icon">
              <client-only>
                <font-awesome-icon :icon="['fas', 'headset']" class="circular-icon bg-purple-100 text-purple-600" />
              </client-only>
            </div>
            <h3>24/7 AI Assistance</h3>
            <p>Round-the-clock support for home automation, helping you maintain independence with quick, reliable guidance.</p>
            <NuxtLink to="/services" class="read-more-btn">Learn More</NuxtLink>
          </div>
        </div>
        <div class="col-lg-4 col-md-6">
          <div class="single-services-box">
            <div class="icon">
              <client-only>
                <font-awesome-icon :icon="['fas', 'bell']" class="circular-icon bg-green-100 text-green-600" />
              </client-only>
            </div>
            <h3>Proactive Alerts</h3>
            <p>Get notifications for maintenance, security risks, and optimizations to prevent issues before they arise.</p>
            <NuxtLink to="/alerts" class="read-more-btn">Explore</NuxtLink>
          </div>
        </div>
        <div class="col-lg-4 col-md-6">
          <div class="single-services-box">
            <div class="icon">
              <client-only>
                <font-awesome-icon :icon="['fas', 'heartbeat']" class="circular-icon bg-blue-100 text-blue-600" />
              </client-only>
            </div>
            <h3>Health & Safety Monitoring</h3>
            <p>Integrate with devices for well-being checks, like leak detection and energy efficiency, supporting your quality of life.</p>
            <NuxtLink to="/monitoring" class="read-more-btn">Get Started</NuxtLink>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { faHeadset, faBell, faHeartbeat } from '@fortawesome/free-solid-svg-icons';
import { library } from '@fortawesome/fontawesome-svg-core';
import { NuxtLink } from '#components';

library.add(faHeadset, faBell, faHeartbeat);

export default {
  name: 'Services',
  components: {
    FontAwesomeIcon,
    NuxtLink
  }
};
</script>

<style scoped>
.services-area {
  position: relative;
  z-index: 1;
  overflow: hidden;
}
.single-services-box {
  text-align: center;
  padding: 30px;
  background-color: #ffffff;
  border-radius: 5px;
  margin-bottom: 30px;
  transition: 0.6s;
  box-shadow: 0 2px 48px 0 rgba(0, 0, 0, 0.08);
}
.single-services-box .icon {
  margin-bottom: 25px;
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
.single-services-box h3 {
  font-size: 22px;
  font-weight: 700;
  margin-bottom: 15px;
}
.single-services-box p {
  margin-bottom: 0;
}
.single-services-box .read-more-btn {
  display: inline-block;
  font-size: 15px;
  font-weight: 600;
  color: #684df4;
  margin-top: 20px;
  position: relative;
}
.single-services-box .read-more-btn::before {
  content: '';
  position: absolute;
  left: 0;
  bottom: 0;
  width: 0;
  height: 1px;
  background-color: #684df4;
  transition: 0.6s;
}
.single-services-box .read-more-btn:hover {
  color: #684df4;
  letter-spacing: 1px;
}
.single-services-box .read-more-btn:hover::before {
  width: 100%;
}
.single-services-box:hover {
  transform: translateY(-10px);
}
</style>
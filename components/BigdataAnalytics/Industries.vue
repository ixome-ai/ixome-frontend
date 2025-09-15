<template>
  <div class="industries-area ptb-80">
    <div class="container">
      <div class="section-title">
        <h2>Industries We Serve</h2>
        <div class="bar"></div>
        <p>With over 35 years of expertise, IXome.ai provides robust AI-driven support for smart home and business electronics across key industries, ensuring seamless integration, troubleshooting, and optimization for leading manufacturers.</p>
      </div>

      <div class="row">
        <div class="col-lg-3 col-md-6 col-sm-6">
          <div class="single-industry-box">
            <div class="icon">
              <client-only>
                <font-awesome-icon :icon="['fas', 'home']" class="circular-icon bg-purple-100 text-purple-600" />
              </client-only>
            </div>
            <h3>Residential</h3>
            <p>Empowering homeowners with intelligent automation for comfort, security, and energy efficiency. We support top-tier systems to deliver reliable, user-friendly experiences.</p>
            <ul class="manufacturers-list">
              <li>Control4</li>
              <li>Lutron</li>
              <li>Sonos</li>
              <li>Nest (Google)</li>
              <li>Philips Hue</li>
              <li>Ring (Amazon)</li>
            </ul>
          </div>
        </div>

        <div class="col-lg-3 col-md-6 col-sm-6">
          <div class="single-industry-box">
            <div class="icon">
              <client-only>
                <font-awesome-icon :icon="['fas', 'building']" class="circular-icon bg-green-100 text-green-600" />
              </client-only>
            </div>
            <h3>Commercial</h3>
            <p>Optimizing business environments with scalable solutions for productivity, security, and operational efficiency. Our AI agents handle complex integrations for enterprise-grade reliability.</p>
            <ul class="manufacturers-list">
              <li>Crestron</li>
              <li>AMX</li>
              <li>Extron</li>
              <li>Cisco</li>
              <li>Bose Professional</li>
              <li>QSC</li>
            </ul>
          </div>
        </div>

        <div class="col-lg-3 col-md-6 col-sm-6">
          <div class="single-industry-box">
            <div class="icon">
              <client-only>
                <font-awesome-icon :icon="['fas', 'hotel']" class="circular-icon bg-blue-100 text-blue-600" />
              </client-only>
            </div>
            <h3>Hospitality</h3>
            <p>Enhancing guest experiences in hotels and venues with intuitive controls for lighting, AV, and climate. We ensure high-availability systems for uninterrupted service.</p>
            <ul class="manufacturers-list">
              <li>Honeywell</li>
              <li>Schneider Electric</li>
              <li>Legrand</li>
              <li>Samsung Hospitality</li>
              <li>LG Commercial</li>
              <li>Ruckus Networks</li>
            </ul>
          </div>
        </div>

        <div class="col-lg-3 col-md-6 col-sm-6 offset-lg-0 offset-md-3 offset-sm-3">
          <div class="single-industry-box">
            <div class="icon">
              <client-only>
                <font-awesome-icon :icon="['fas', 'tools']" class="circular-icon bg-red-100 text-red-600" />
              </client-only>
            </div>
            <h3>Installers</h3>
            <p>Supporting professional integrators with tools for efficient deployment, diagnostics, and maintenance. Our platform streamlines workflows for faster project completion and client satisfaction.</p>
            <ul class="manufacturers-list">
              <li>Yamaha</li>
              <li>Denon</li>
              <li>Marantz</li>
              <li>Savant</li>
              <li>RTI</li>
              <li>Universal Remote Control</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { faHome, faBuilding, faHotel, faTools } from '@fortawesome/free-solid-svg-icons';
import { library } from '@fortawesome/fontawesome-svg-core';

library.add(faHome, faBuilding, faHotel, faTools);

export default {
  name: 'Industries',
  components: {
    FontAwesomeIcon
  }
};
</script>

<style scoped>
.industries-area {
  position: relative;
  z-index: 1;
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

.single-industry-box {
  text-align: center;
  border-radius: 5px;
  margin-bottom: 30px;
  box-shadow: 0 2px 48px 0 rgba(0, 0, 0, 0.08);
  transition: 0.6s;
  padding: 20px;
  background-color: #ffffff;
}

.single-industry-box .icon {
  margin-bottom: 15px;
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

.single-industry-box h3 {
  font-size: 22px;
  font-weight: 700;
  margin-bottom: 10px;
}

.single-industry-box p {
  margin-bottom: 15px;
  font-size: 15px;
}

.manufacturers-list {
  list-style-type: disc;
  padding-left: 20px;
  text-align: left;
  font-size: 14px;
  color: #5c5c5c;
}

.manufacturers-list li {
  margin-bottom: 5px;
}

.single-industry-box:hover {
  transform: translateY(-10px);
}
</style>
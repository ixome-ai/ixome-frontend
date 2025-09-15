<template>
  <div class="bigdata-discover-area ptb-80">
    <div class="container">
      <div class="section-title">
        <h2>Discover IXome.ai Features</h2>
        <div class="bar"></div>
        <p>With over 35 years in business, IXome.ai offers simple, flexible solutions backed by vast knowledge, focusing on customer satisfaction, independence, and proactive care for your smart home.</p>
      </div>

      <div class="row">
        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="single-discover-box">
            <div class="icon">
              <client-only>
                <font-awesome-icon :icon="['fas', 'couch']" class="circular-icon bg-purple-100 text-purple-600" />
              </client-only>
            </div>
            <h3>Simplified Daily Living</h3>
            <p>Enjoy hassle-free Control4 and Lutron management with intuitive AI that eases frustrations and promotes relaxation at home.</p>
          </div>
        </div>

        <div class="col-lg-4 col-md-6 col-sm-6">
          <div class="single-discover-box">
            <div class="icon">
              <client-only>
                <font-awesome-icon :icon="['fas', 'expand-arrows-alt']" class="circular-icon bg-green-100 text-green-600" />
              </client-only>
            </div>
            <h3>Scalable Flexibility</h3>
            <p>Adaptable support that scales with your needs, ensuring long-term reliability and integration for multiple devices or homes.</p>
          </div>
        </div>

        <div class="col-lg-4 col-md-6 col-sm-6 offset-lg-0 offset-md-3 offset-sm-3">
          <div class="single-discover-box">
            <div class="icon">
              <client-only>
                <font-awesome-icon :icon="['fas', 'user-check']" class="circular-icon bg-blue-100 text-blue-600" />
              </client-only>
            </div>
            <h3>Customer-Centric Excellence</h3>
            <p>Prioritizing your satisfaction with personalized insights, privacy assurances, and continuous improvements based on user feedback.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { faCouch, faExpandArrowsAlt, faUserCheck } from '@fortawesome/free-solid-svg-icons';
import { library } from '@fortawesome/fontawesome-svg-core';

library.add(faCouch, faExpandArrowsAlt, faUserCheck);

export default {
  name: 'Discover',
  components: {
    FontAwesomeIcon
  }
};
</script>

<style scoped>
.bigdata-discover-area {
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

.single-discover-box {
  text-align: center;
  padding: 30px;
  background-color: #ffffff;
  border-radius: 5px;
  margin-bottom: 30px;
  box-shadow: 0 2px 48px 0 rgba(0, 0, 0, 0.08);
  transition: 0.6s;
}

.single-discover-box .icon {
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

.single-discover-box h3 {
  font-size: 22px;
  font-weight: 700;
  margin-bottom: 15px;
}

.single-discover-box p {
  margin-bottom: 0;
}

.single-discover-box:hover {
  transform: translateY(-10px);
}
</style>
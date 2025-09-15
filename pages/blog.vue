<template>
  <div class="blog-area ptb-80">
    <div class="container">
      <div class="row">
        <div class="col-lg-8 col-md-12">
          <div class="row">
            <div v-for="article in articles" :key="article.id" class="col-lg-6 col-md-6">
              <div class="single-blog-post sparkle-card">
                <div class="blog-image">
                  <NuxtLink :to="`/blog/${article.slug}`">
                    <img v-if="article.image" :src="`${strapiUrl}${article.image.url}`" alt="image" />
                    <img v-else src="~/assets/img/blog-image/placeholder.jpg" alt="placeholder" />
                  </NuxtLink>
                  <div class="date">
                    <i class="fas fa-calendar-alt"></i> {{ formatDate(article.publishedAt) }}
                  </div>
                </div>
                <div class="blog-post-content">
                  <h3>
                    <NuxtLink :to="`/blog/${article.slug}`">{{ article.title }}</NuxtLink>
                  </h3>
                  <span>by <a href="#">{{ article.author || 'Admin' }}</a></span>
                  <p>{{ article.description || (article.content ? article.content.substring(0, 150) + '...' : '') }}</p>
                  <NuxtLink :to="`/blog/${article.slug}`" class="read-more-btn">
                    Read More <i class="fas fa-arrow-right"></i>
                  </NuxtLink>
                </div>
              </div>
            </div>
            <div v-if="!articles.length && !loading" class="no-articles">No articles found.</div>
          </div>
          <div v-if="loading" class="loading">Loading more...</div>
        </div>
        <div class="col-lg-4 col-md-12">
          <BlogSidebar />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import BlogSidebar from '~/components/BlogSidebar.vue';

const strapiUrl = useRuntimeConfig().public.strapiUrl;
const articles = ref([]);
const currentPage = ref(1);
const pageSize = 6;
const loading = ref(false);
const hasMore = ref(true);
const observer = ref(null);

useHead({
  title: 'Ixome Blog - Latest News and Insights on Smart Home Technology',
  meta: [
    { name: 'description', content: 'Explore the latest articles on Control4, Lutron, and AI-driven smart home solutions from Ixome.ai.' }
  ]
});

const fetchArticles = async (reset = false) => {
  if (loading.value || !hasMore.value) return;
  loading.value = true;
  const route = useRoute();
  let queryParams = `populate=*&pagination[page]=${currentPage.value}&pagination[pageSize]=${pageSize}&sort=publishedAt:desc`;
  const category = route.query.category;
  if (category && category.trim() !== '') {
    queryParams += `&filters[category][name][$eq]=${encodeURIComponent(category)}`;
  }
  try {
    const response = await $fetch(`${strapiUrl}/api/articles?${queryParams}`);
    if (reset) articles.value = [];
    articles.value = [...articles.value, ...response.data];
    hasMore.value = currentPage.value < response.meta.pagination.pageCount;
    currentPage.value++;
  } catch (error) {
    console.error('Error fetching articles:', error);
  }
  loading.value = false;
};

const formatDate = (date) => {
  return new Date(date).toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' });
};

onMounted(() => {
  fetchArticles();
  const target = document.querySelector('.blog-area');
  observer.value = new IntersectionObserver((entries) => {
    if (entries[0].isIntersecting && hasMore.value) fetchArticles();
  }, { threshold: 0.1 });
  observer.value.observe(target);
  if (process.client && window.gtag) {
    gtag('event', 'page_view', { page_title: 'Blog List', page_location: window.location.href });
  }
});

onUnmounted(() => {
  if (observer.value) observer.value.disconnect();
});
</script>

<style scoped>
.blog-area {
  padding-top: 80px;
  padding-bottom: 80px;
}
.single-blog-post {
  background: #fff;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  transition: transform 0.3s, box-shadow 0.3s;
}
.sparkle-card:hover {
  transform: scale(1.05);
  box-shadow: 0 0 20px rgba(128, 0, 128, 0.5); /* Purple glow */
  animation: pulse 1s infinite;
}
@keyframes pulse {
  0% { opacity: 1; }
  50% { opacity: 0.8; }
  100% { opacity: 1; }
}
.blog-image {
  position: relative;
}
.blog-image img {
  width: 100%;
  height: auto;
}
.date {
  position: absolute;
  bottom: 10px;
  left: 10px;
  background: rgba(0,0,0,0.7);
  color: #fff;
  padding: 5px 10px;
  border-radius: 4px;
  font-size: 12px;
}
.blog-post-content {
  padding: 20px;
}
.blog-post-content h3 {
  font-size: 18px;
  margin-bottom: 10px;
}
.blog-post-content span {
  font-size: 14px;
  color: #666;
}
.blog-post-content p {
  font-size: 14px;
  color: #333;
  margin: 10px 0;
}
.read-more-btn {
  color: #007bff;
  text-decoration: none;
  font-weight: 600;
}
.loading, .no-articles {
  text-align: center;
  margin: 20px 0;
}
</style>
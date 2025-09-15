<!-- Path: /home/vincent/ixome/ixome-frontend/website-frontend/frontend/pages/blog/[slug].vue -->
<template>
    <div class="blog-details-area ptb-80">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 col-md-12">
            <div class="blog-details">
              <div class="article-img">
                <img v-if="article?.image?.data" :src="`${STRAPI_BASE_URL}${article.image.data.attributes.url}`" alt="image" />
                <img v-else src="~/assets/img/blog-image/placeholder.jpg" alt="placeholder" />
                <div class="date">{{ formatDate(article.publishedAt) }}</div>
              </div>
              <div class="article-content">
                <h3>{{ article.title }}</h3>
                <div class="entry-meta">
                  <ul>
                    <li>By: {{ article.author || 'Admin' }}</li>
                    <li>Category: {{ article.category?.data?.attributes?.name || 'Uncategorized' }}</li>
                  </ul>
                </div>
                <div v-html="article.content"></div>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-md-12">
            <BlogSidebar />
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted, watch } from 'vue';
  import BlogSidebar from '~/components/BlogSidebar.vue';
  
  const STRAPI_BASE_URL = 'http://127.0.0.1:1337';
  const article = ref({});
  
  const { params } = useRoute();
  
  const fetchArticle = async () => {
    try {
      const response = await $fetch(`${STRAPI_BASE_URL}/api/articles?filters[slug][$eq]=${params.slug}&populate=deep`);
      article.value = response.data[0]?.attributes || {};
    } catch (error) {
      console.error('Error fetching article:', error);
    }
  };
  
  const formatDate = (date) => {
    return new Date(date).toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' });
  };
  
  onMounted(() => {
    fetchArticle();
    if (process.client && window.gtag) {
      gtag('event', 'page_view', { page_title: article.value.title || 'Article', page_location: window.location.href });
    }
  });
  
  watch(article, () => {
    useHead({
      title: article.value.title || 'Article',
      meta: [
        { name: 'description', content: article.value.description || article.value.content?.substring(0, 160) + '...' }
      ]
    });
  });
  </script>
  
  <style scoped>
  .blog-details-area {
    padding-top: 80px;
    padding-bottom: 80px;
  }
  .article-img {
    position: relative;
    margin-bottom: 30px;
  }
  .article-img img {
    width: 100%;
    border-radius: 8px;
  }
  .date {
    position: absolute;
    bottom: 20px;
    left: 20px;
    background: rgba(0,0,0,0.7);
    color: #fff;
    padding: 10px;
    border-radius: 4px;
  }
  .article-content h3 {
    font-size: 24px;
    margin-bottom: 20px;
  }
  .entry-meta ul {
    list-style: none;
    padding: 0;
    margin: 0 0 20px;
    display: flex;
    gap: 20px;
    font-size: 14px;
    color: #666;
  }
  .article-content {
    line-height: 1.6;
    color: #333;
  }
  </style>
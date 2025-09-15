<template>
  <div class="widget-area">
    <div class="widget widget_search">
      <form class="search-form">
        <label>
          <input type="search" class="search-field" placeholder="Search blog..." v-model="searchQuery" @input="handleSearch" />
        </label>
        <button type="submit"><i class="fas fa-search"></i></button>
      </form>
    </div>
    <div class="widget widget_filter">
      <h3>Filter by Category</h3>
      <select v-model="selectedCategory" @change="filterArticles">
        <option value="">All</option>
        <option v-for="category in categories" :key="category.id" :value="category.name">{{ category.name }}</option>
      </select>
    </div>
    <div class="widget widget_categories">
      <h3>Categories</h3>
      <ul>
        <li v-for="category in categories" :key="category.id">
          <a href="#">{{ category.name }}</a>
        </li>
        <li v-if="!categories.length">No categories found.</li>
      </ul>
    </div>
    <div class="widget widget_recent_posts">
      <h3>Recent Posts</h3>
      <ul>
        <li v-for="post in recentPosts" :key="post.id">
          <NuxtLink :to="`/blog/${post.slug}`">{{ post.title }}</NuxtLink>
        </li>
        <li v-if="!recentPosts.length">No recent posts.</li>
      </ul>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const strapiUrl = useRuntimeConfig().public.strapiUrl;
const searchQuery = ref('');
const categories = ref([]);
const recentPosts = ref([]);
const selectedCategory = ref('');

const fetchCategories = async () => {
  try {
    const response = await $fetch(`${strapiUrl}/api/categories?populate=*`);
    categories.value = response.data || [];
  } catch (error) {
    console.error('Error fetching categories:', error);
  }
};

const fetchRecentPosts = async () => {
  try {
    const response = await $fetch(`${strapiUrl}/api/articles?sort=publishedAt:desc&pagination[limit]=5&populate=*`);
    recentPosts.value = response.data || [];
  } catch (error) {
    console.error('Error fetching recent posts:', error);
  }
};

const handleSearch = () => {
  console.log('Search:', searchQuery.value);
};

const filterArticles = () => {
  useRouter().push({ query: { category: selectedCategory.value } });
};

onMounted(() => {
  fetchCategories();
  fetchRecentPosts();
});
</script>

<style scoped>
/* Existing styles */
</style>
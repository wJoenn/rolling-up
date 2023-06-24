<template>
  <div class="side-nav">
    <router-link :to="{ name: 'Logout' }">Log out</router-link>
  </div>
</template>

<script setup lang="ts">

</script>

<style scoped lang="scss">
  .side-nav {
    background-color: white;
    display: flex;
    flex-direction: column;
    height: 100%;
    width: 70%;
  }
</style>

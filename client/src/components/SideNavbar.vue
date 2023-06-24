<template>
  <div class="side-nav">
    <div class="gif"><div /></div>

    <router-link :to="{ name: 'Logout' }">
      <fai icon="fa-solid fa-right-from-bracket" /> Log out
    </router-link>
  </div>
</template>

<script setup lang="ts">

</script>

<style scoped lang="scss">
  .side-nav {
    background-color: #222222;
    box-shadow: 0 5px 20px black;
    display: flex;
    flex-direction: column;
    gap: 50px;
    height: 100%;
    padding: 30px;
    width: 65%;
  }
</style>

<template>
  <div>
    <a href="https://vitejs.dev" target="_blank">
      <img src="../assets/images/vite.svg" class="logo" alt="Vite logo">
    </a>
    <a href="https://vuejs.org/" target="_blank">
      <img src="../assets/images/vue.svg" class="logo vue" alt="Vue logo">
    </a>
  </div>
  <HelloWorld msg="Vite + Vue" />
</template>

<script setup lang="ts">
  import HelloWorld from "../components/HelloWorld.vue"
</script>

<style scoped lang="scss">
  .logo {
    height: 10em;
    padding: 1.5em;
    will-change: filter;
    transition: filter 300ms;

    &:hover {
      filter: drop-shadow(0 0 2em #646cffaa);
    }

    &.vue:hover {
      filter: drop-shadow(0 0 2em #42b883aa);
    }
  }
</style>

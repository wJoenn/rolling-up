<template>
  <router-view />
</template>

<script setup lang="ts">
  import { onMounted } from "vue"
  import useAppStore from "./stores/AppStore.ts"

  const appStore = useAppStore()

  onMounted(() => {
    appStore.getTotalCharactersCreated()
  })
</script>

<style lang="scss">
  #app {
    flex-grow: 1;
  }
</style>

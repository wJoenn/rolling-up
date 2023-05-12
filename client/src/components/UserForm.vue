<template>
  <div>
    <div>
      <button @click="hasAccount = true">Login</button>
      <button @click="hasAccount = false">Signup</button>
    </div>

    <SessionsNew v-if="hasAccount" />
    <RegistrationsNew v-else />
  </div>
</template>

<script setup lang="ts">
  import { ref } from "vue"
  import SessionsNew from "./SessionsNew.vue"
  import RegistrationsNew from "./RegistrationsNew.vue"

  const hasAccount = ref(true)
</script>

<style scoped lang="scss">

</style>

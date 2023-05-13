<template>
  <div>
    <button v-if="userStore.isLoggedIn" @click="userStore.logout">Logout</button>
    <div v-else>
      <div>
        <button @click="hasAccount = true">Login</button>
        <button @click="hasAccount = false">Signup</button>
      </div>

      <SessionsNew v-if="hasAccount" />
      <RegistrationsNew v-else />
    </div>
  </div>
</template>

<script setup lang="ts">
  import { ref } from "vue"
  import useUserStore from "../stores/UserStore.ts"
  import SessionsNew from "./SessionsNew.vue"
  import RegistrationsNew from "./RegistrationsNew.vue"

  const userStore = useUserStore()

  const hasAccount = ref(true)
</script>

<style scoped lang="scss">
</style>

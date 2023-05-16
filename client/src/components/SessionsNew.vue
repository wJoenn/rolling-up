<template>
  <div class="form">
    <h2>Log in</h2>

    <form @submit.prevent="handleSubmit">
      <span v-if="error" class="error">{{ error }}</span>

      <div class="field">
        <label for="email">Email</label>
        <input v-model="email" type="text" name="email">
      </div>

      <div class="field">
        <label for="password">Password</label>

        <div class="password">
          <input v-model="password" type="password" name="password">
          <fai :icon="['fa-solid', show ? 'fa-eye-slash' : 'fa-eye']" @click="handleClick" />
        </div>
      </div>

      <button class="btn-purple">Log in</button>
    </form>
  </div>
</template>

<script setup lang="ts">
  import { ref } from "vue"
  import useUserStore from "../stores/UserStore.ts"
  import togglePassword from "../composables/togglePassword.ts"

  const email = ref("")
  const password = ref("")
  const error = ref("")
  const show = ref(false)

  const userStore = useUserStore()

  const handleClick = () => {
    togglePassword(show)
  }

  const handleSubmit = async () => {
    const params = {
      user: {
        email: email.value,
        password: password.value
      }
    }

    if (!await userStore.login(params)) error.value = userStore.errors[0]
  }
</script>

<style scoped lang="scss">
</style>

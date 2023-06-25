<template>
  <div class="form">
    <h2>Sign up</h2>

    <form @submit.prevent="handleSubmit">
      <div class="field">
        <label for="email">Email</label>
        <input v-model="email" type="text" name="email">
        <span v-if="errors.email" class="error">{{ errors.email }}</span>
      </div>

      <div class="field">
        <label for="password">Password</label>
        <div class="password">
          <input v-model="password" type="password" name="password">
          <fai :icon="['fa-solid', show ? 'fa-eye-slash' : 'fa-eye']" @click="handleClick" />
        </div>
        <span v-if="errors.password" class="error">{{ errors.password }}</span>
      </div>

      <div class="field">
        <label for="password-confirmation">Password confirmation</label>
        <div class="password">
          <input v-model="passwordConfirmation" type="password" name="password_confirmation">
          <fai :icon="['fa-solid', show ? 'fa-eye-slash' : 'fa-eye']" @click="handleClick" />
        </div>
        <span v-if="errors.passwordConfirmation" class="error">{{ errors.passwordConfirmation }}</span>
      </div>

      <button class="btn-purple">SIGN UP</button>
    </form>
  </div>
</template>

<script setup lang="ts">
  import { computed, ref, onUnmounted } from "vue"
  import { useRouter } from "vue-router"
  import useUserStore from "../stores/UserStore.ts"
  import togglePassword from "../composables/togglePassword.ts"

  interface UserErrors {
    email?: string
    password?: string
    passwordConfirmation?: string
  }

  const email = ref("")
  const password = ref("")
  const passwordConfirmation = ref("")
  const show = ref(false)

  const router = useRouter()
  const userStore = useUserStore()
  const errors = computed<UserErrors>(() => userStore.errors)

  const handleClick = () => {
    togglePassword(show)
  }

  const handleSubmit = async () => {
    const params = {
      user: {
        email: email.value,
        password: password.value,
        password_confirmation: passwordConfirmation.value
      }
    }

    const isSignedUp = await userStore.signup(params)

    if (isSignedUp) router.push({ name: "CharactersIndex" })
  }

  onUnmounted(() => userStore.resetErrors())
</script>

<style scoped lang="scss">
</style>

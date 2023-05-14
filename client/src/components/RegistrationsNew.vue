<template>
  <div>
    <form @submit.prevent="handleSubmit">
      <div>
        <label for="email">Email</label>
        <input v-model="email" type="text" name="email">
        <span v-if="errors.email">{{ errors.email }}</span>
      </div>

      <div>
        <label for="password">Password</label>
        <input v-model="password" type="password" name="password">
        <span v-if="errors.password">{{ errors.password }}</span>
      </div>

      <div>
        <label for="password-confirmation">Password confirmation</label>
        <input v-model="passwordConfirmation" type="password" name="password-confirmation">
        <span v-if="errors.passwordConfirmation">{{ errors.passwordConfirmation }}</span>
      </div>

      <button>Sign up</button>
    </form>
  </div>
</template>

<script setup lang="ts">
  import { ref } from "vue"
  import useUserStore from "../stores/UserStore.ts"

  interface Errors {
    email?: string
    password?: string
    passwordConfirmation?: string
  }

  const email = ref("")
  const password = ref("")
  const passwordConfirmation = ref("")
  const errors = ref<Errors>({})

  const userStore = useUserStore()

  const handleSubmit = async () => {
    const params = {
      user: {
        email: email.value,
        password: password.value,
        password_confirmation: passwordConfirmation.value
      }
    }

    if (!await userStore.signup(params)) sortErrors(userStore.errors)
  }

  const sortErrors = (err: string[]) => {
    errors.value = {}
    err.forEach(e => {
      if (/email/i.test(e)) errors.value.email = e
      else if (/confirmation/i.test(e)) errors.value.passwordConfirmation = e
      else if (/password/i.test(e)) errors.value.password = e
    })
  }
</script>

<style scoped lang="scss">
</style>

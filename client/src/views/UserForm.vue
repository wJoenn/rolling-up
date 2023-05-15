<template>
  <div id="user-forms" class="container">
    <router-link :to="{ name: 'Home' }"><fai icon="fa-solid fa-chevron-left" /></router-link>

    <div v-if="hasAccount">
      <SessionsNew />
      <button class="link" @click="hasAccount = false">Don't have an account yet ?</button>
    </div>

    <div v-else>
      <RegistrationsNew />
      <button class="link" @click="hasAccount = true">Already have an account ?</button>
    </div>

    <div />
  </div>
</template>

<script setup lang="ts">
  import { ref } from "vue"
  import SessionsNew from "../components/SessionsNew.vue"
  import RegistrationsNew from "../components/RegistrationsNew.vue"

  const props = defineProps({
    action: String
  })

  const hasAccount = ref(props.action === "sign_in")
</script>

<style scoped lang="scss">
  #user-forms {
    display: flex;
    flex-direction: column;
    height: 100%;
    justify-content: space-between;
    padding: 20px 0;

    .link {
      background-color: transparent;
      box-shadow: none;
      font-weight: 700;
      margin: 0 auto;

      // gradient text
      background: linear-gradient(135deg, rgb(91, 115, 224), rgb(165, 73, 165));
      background-clip: text;
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
  }
</style>

<template>
  <h1>{{ msg }}</h1>

  <div class="card">
    <button type="button" @click="count++">count is {{ count }}</button>
    <p>Edit<code>components/HelloWorld.vue</code> to test HMR</p>
  </div>

  <p>
    Check out
    <a href="https://vuejs.org/guide/quick-start.html#local" target="_blank">create-vue</a>
    , the official Vue + Vite starter
  </p>
  <p>
    Install
    <a href="https://github.com/vuejs/language-tools" target="_blank">Volar</a>
    in your IDE for a better DX
  </p>
  <p class="read-the-docs">Click on the Vite and Vue logos to learn more</p>
</template>

<script setup lang="ts">
  import { ref } from "vue"

  defineProps<{ msg: string }>()

  const count = ref(0)
</script>

<style scoped lang="scss">
  button {
    background-color: #222222;
    border: none;
    border-radius: 5px;
    box-shadow: 0 0 10px rgb(0, 0, 0);
    color: inherit;
    cursor: pointer;
    font: inherit;
    padding: 0.5rem 1rem
  }

  div {
    align-items: center;
    display: flex;
    flex-direction: column;
    gap: 10px;
    margin: 20px 0;
  }
  .read-the-docs {
    color: #888;
  }
</style>

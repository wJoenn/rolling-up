<template>
  <div id="home" class="container">
    <div />

    <div>
      <img src="../assets/images/dice.gif" alt="dice">
      <h1>Rollingup</h1>
      <p>Welcome to the best DnD character creation assistant. Create an account and access your characters anytime.</p>
    </div>

    <div class="buttons">
      <router-link :to="{ name: 'UserForm', params: { action: 'sign_in' } }" class="btn btn-purple">
        <span>LOG IN</span>
        <fai icon="fa-solid fa-dragon" />
      </router-link>

      <router-link :to="{ name: 'UserForm', params: { action: 'sign_up' } }" class="btn btn-purple">
        <span>CREATE AN ACCOUNT</span>
        <fai icon="fa-solid fa-dragon" />
      </router-link>
    </div>
  </div>
</template>

<script setup lang="ts">
</script>

<style scoped lang="scss">
#home {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  min-height: 100svh;
  text-align: center;

  h1 {
    font-size: 60px;
    margin-bottom: 20px;
  }

  img {
    margin-bottom: -50px;
  }

  .buttons {
    display: flex;
    flex-direction: column;
    font-weight: 700;
    gap: 20px;
  }
}
</style>

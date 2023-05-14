<template>
  <div id="home" class="container">
    <div />

    <div>
      <img src="../assets/images/dice.gif" alt="dice">
      <h1>Rollingup</h1>
      <p>Welcome to the best DnD character creation assistant. Create an account and </p>
    </div>

    <div class="buttons">
      <button>Login</button>
      <button>Signup</button>
    </div>

    <!-- <UserForm /> -->
  </div>
</template>

<script setup lang="ts">
  // import UserForm from "../components/UserForm.vue"
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

    button {
      font: inherit;
      padding: $padding;
    }
  }
}
</style>

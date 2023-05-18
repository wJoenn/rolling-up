<template>
  <div id="characters-index">
    <div class="navbar">
      <button><fai icon="fa-solid fa-bars" /></button>
      <h2>Your Characters</h2>
      <router-link :to="{ name: 'CharactersNew' }"><fai icon="fa-solid fa-plus" /></router-link>
    </div>

    <div class="container">
      <div class="characters">
        <router-link :to="{ name: 'CharactersNew' }" class="character">
          <div class="character-shadow">
            <fai icon="fa-solid fa-plus" />
          </div>
          <span>Create a Character</span>
        </router-link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
</script>

<style scoped lang="scss">
  #characters-index .character {
    align-items: center;
    background-color: $darkgrey;
    border-radius: 10px;
    display: flex;
    padding: 1rem;

    span {
      display: inline-block;
      flex-grow: 1;
      text-align: center;
    }

    .character-shadow {
      align-items: center;
      background-image: url("../../assets/images/character_shadow.png");
      background-size: cover;
      display: flex;
      justify-content: center;
      height: 75px;
      width: 75px;
    }
  }
</style>

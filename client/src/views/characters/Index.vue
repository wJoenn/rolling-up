<template>
  <div id="characters-index">
    <div :class="{ visible: showSideNav }" class="modal" @click="hideSideNav">
      <Navbar />
    </div>

    <div class="navbar">
      <button @click="showSideNav = true"><fai icon="fa-solid fa-bars" /></button>
      <h2>Your Characters</h2>
      <router-link :to="{ name: 'CharactersNew' }" class="last">
        <fai icon="fa-solid fa-plus" />
      </router-link>
    </div>

    <div class="container">
      <div class="characters">
        <div v-for="character in characters" :key="(character.id as number)" class="character">
          <div class="character-shadow" />
          <span>{{ character.name }}</span>
        </div>

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
  import { onMounted, ref } from "vue"
  import Navbar from "../../components/Navbar.vue"
  import useCharacterStore from "../../stores/CharacterStore.ts"
  import Character from "../../types/Character.ts"

  const characters = ref<Character[]>([])
  const showSideNav = ref(false)

  const characterStore = useCharacterStore()

  const hideSideNav = (event: MouseEvent) => {
    if (event.target === event.currentTarget) showSideNav.value = false
  }

  onMounted(async () => {
    characters.value = await characterStore.getCharacters()
  })
</script>

<style scoped lang="scss">
  #characters-index .characters {
    padding: 20px 0;

    .character {
      align-items: center;
      background-color: $darkgrey;
      border-radius: 10px;
      display: flex;
      margin-bottom: 10px;
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
  }
</style>

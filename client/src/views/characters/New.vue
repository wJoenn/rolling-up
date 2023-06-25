<template>
  <div id="characters-new">
    <form @submit.prevent="handleSubmit">
      <div class="navbar">
        <router-link :to="{ name: 'Home' }"><fai icon="fa-solid fa-chevron-left" /></router-link>
        <h2>Name</h2>
        <button class="gradient-text last">Done</button>
      </div>

      <div class="container">
        <div>
          <div class="field">
            <label for="name">Name</label>
            <input type="text" name="name">
            <span v-if="errors.name" class="error">{{ errors.name }}</span>
          </div>
        </div>
      </div>
    </form>
  </div>
</template>

<script setup lang="ts">
  import { computed } from "vue"
  import { useRouter } from "vue-router"
  import useCharacterStore from "../../stores/CharacterStore.ts"

  interface CharacterErrors {
    name?: string
  }

  const router = useRouter()
  const characterStore = useCharacterStore()

  const errors = computed<CharacterErrors>(() => characterStore.errors)

  const handleSubmit = async (event: Event) => {
    const formData = new FormData(event.target as HTMLFormElement)
    const isCreated = await characterStore.createCharacter(formData)

    if (isCreated) router.push({ name: "CharactersIndex" })
  }
</script>

<style scoped lang="scss">
  #characters-new {
    height: 100%;

    form {
      display: flex;
      flex-direction: column;
      height: 100%;

      .container {
        display: flex;
        flex-direction: column;
        justify-content: center;

        > div {
          margin-top: -80px;
        }
      }

      .field {
        display: flex;
        flex-direction: column;
        justify-content: center;
      }
    }
    .last {
      font-size: 20px;
    }
  }
</style>

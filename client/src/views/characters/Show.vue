<template>
  <div id="character">
    <div class="navbar">
      <router-link :to="{ name: 'Home' }"><fai icon="fa-solid fa-chevron-left" /></router-link>
      <h2>Showcase</h2>
      <button class="gradient-text last">Delete</button>
    </div>

    <div class="showcase container">
      <img src="../../assets/images/character_shadow.png" alt="character">

      <div class="details">
        <h2>{{ character?.name }}</h2>

        <ul class="stats">
          <li class="stat">
            <p class="name">STR</p>
            <p class="modifier">{{ modifier(character?.strength as number) }}</p>
            <span>{{ character?.strength }}</span>
          </li>

          <li class="stat">
            <p class="name">DEX</p>
            <p class="modifier">{{ modifier(character?.dexterity as number) }}</p>
            <span>{{ character?.dexterity }}</span>
          </li>

          <li class="stat">
            <p class="name">CON</p>
            <p class="modifier">{{ modifier(character?.constitution as number) }}</p>
            <span>{{ character?.constitution }}</span>
          </li>

          <li class="stat">
            <p class="name">INT</p>
            <p class="modifier">{{ modifier(character?.intelligence as number) }}</p>
            <span>{{ character?.intelligence }}</span>
          </li>

          <li class="stat">
            <p class="name">WIS</p>
            <p class="modifier">{{ modifier(character?.wisdom as number) }}</p>
            <span>{{ character?.wisdom }}</span>
          </li>

          <li class="stat">
            <p class="name">CHA</p>
            <p class="modifier">{{ modifier(character?.charisma as number) }}</p>
            <span>{{ character?.charisma }}</span>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { onMounted, ref } from "vue"
  import { useRouter } from "vue-router"

  import Character from "../../types/Character.ts"
  import useCharacterStore from "../../stores/CharacterStore.ts"

  const props = defineProps({
    id: String
  })

  const characterStore = useCharacterStore()
  const router = useRouter()

  const character = ref<Character>()

  const modifier = (stat: number): number => Math.floor((stat - 10) / 2)

  onMounted(async () => {
    const char = await characterStore.getCharacter(props.id as string)

    if (char) character.value = char
    else router.push({ name: "CharactersIndex" })
  })
</script>

<style scoped lang="scss">
  #character {
    display: flex;
    flex-direction: column;
    height: 100%;

    .showcase {
      background-color: #191919;
      border-radius: 10px;
      box-shadow: 0 0 10px black;
      display: flex;
      flex-direction: column;
      flex-grow: 1;
      justify-content: space-around;
      margin: 50px auto;
      padding: 20px;

      h2 {
        margin-bottom: 20px;
      }

      .stats {
        display: grid;
        gap: 10px;
        grid-template-columns: 1fr 1fr 1fr 1fr 1fr 1fr;

        .stat {
          background-color: #222222;
          border-radius: 5px;
          box-shadow: 0 0 5px black;
          font-size: 0.5rem;
          padding: 4px 2px 2px;
          position: relative;
          text-align: center;

          .name {
            margin-bottom: 2px;
          }

          .modifier {
            border-radius: 5px;
            background-color: #191919;
            padding: 0.75rem 0.5rem;
          }

          span {
            background-color: #222222;
            border-radius: 50%;
            bottom: -7px;
            box-shadow: 0 0 5px black;
            display: inline-block;
            left: 50%;
            padding: 0.2rem 0.4rem;
            position: absolute;
            translate: -50% 0;
          }
        }
      }
    }
  }
</style>

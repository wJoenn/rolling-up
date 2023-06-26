<template>
  <div>
    Hello {{ character?.name }}
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

  onMounted(async () => {
    const char = await characterStore.getCharacter(props.id as string)

    if (char) character.value = char
    else router.push({ name: "CharactersIndex" })
  })
</script>

<style scoped lang="scss">
</style>

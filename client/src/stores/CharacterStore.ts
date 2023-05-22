import { ref } from "vue"
import { defineStore } from "pinia"
import axios from "axios"

import useUserStore from "./UserStore.ts"
import handleApiErrors from "../composables/handleApiErrors.ts"
import Character from "../types/Character.ts"

const API_URL = "http://localhost:3000/characters"

const useCharacterStore = defineStore("CharacterStore", () => {
  const errors = ref<string[]>([])

  const createCharacter = async (params: FormData) => {
    try {
      await axios.post(API_URL, params, { headers: {
        Authorization: authToken,
        "Content-Type": "application/json"
      } })

      return true
    } catch (err) {
      errors.value = handleApiErrors(err)

      return false
    }
  }

  const getCharacters = async () => {
    try {
      const res = await axios.get(API_URL, { headers: { Authorization: authToken } })

      const characters: Character[] = res.data.characters
      return characters
    } catch {
      return []
    }
  }

  // Private

  const authToken = useUserStore().authToken

  return { errors, createCharacter, getCharacters }
})

export default useCharacterStore

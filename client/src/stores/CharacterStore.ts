import { ref } from "vue"
import { defineStore } from "pinia"
import axios from "axios"

import handleApiErrors from "../composables/handleApiErrors.ts"
import Character from "../types/Character.ts"

const API_URL = import.meta.env.VITE_API_URL

const useCharacterStore = defineStore("CharacterStore", () => {
  const errors = ref([""])

  const createCharacter = async (params: FormData): Promise<boolean> => {
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

  const getCharacters = async (): Promise<Character[]> => {
    try {
      const res = await axios.get(API_URL, { headers: { Authorization: authToken } })

      return res.data.characters
    } catch {
      return []
    }
  }

  // Private

  const authToken = localStorage.getItem("authToken")

  return { errors, createCharacter, getCharacters }
})

export default useCharacterStore

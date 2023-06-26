import { ref } from "vue"
import { defineStore } from "pinia"
import axios from "axios"

import handleApiErrors from "../composables/handleApiErrors.ts"
import Character from "../types/Character.ts"

const API_URL = import.meta.env.VITE_API_URL

const useCharacterStore = defineStore("CharacterStore", () => {
  const errors = ref({})

  const createCharacter = async (params: FormData): Promise<boolean> => {
    try {
      await axios.post(`${API_URL}/characters`, params, { headers: {
        Authorization: authToken,
        "Content-Type": "application/json"
      } })

      return true
    } catch (err) {
      errors.value = handleApiErrors(err, "name")

      return false
    }
  }

  const getCharacter = async (id: string): Promise<Character | false> => {
    try {
      const res = await axios.get(`${API_URL}/characters/${id}`, { headers: { Authorization: authToken } })

      return res.data.character
    } catch {
      return false
    }
  }

  const getCharacters = async (): Promise<Character[]> => {
    try {
      const res = await axios.get(`${API_URL}/characters`, { headers: { Authorization: authToken } })

      return res.data.characters
    } catch {
      return []
    }
  }

  // Private

  const authToken = localStorage.getItem("authToken")

  return { errors, createCharacter, getCharacter, getCharacters }
})

export default useCharacterStore

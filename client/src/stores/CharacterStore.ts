import { defineStore } from "pinia"
import axios from "axios"

import Character from "../types/Character.ts"

const authToken = localStorage.getItem("authToken")

const useCharacterStore = defineStore("CharacterStore", () => {
  const getCharacters = async () => {
    try {
      const res = await axios.get("http://localhost:3000/characters", { headers: { Authorization: authToken } })

      const characters: Character[] = res.data.characters
      return characters
    } catch {
      return []
    }
  }

  return { getCharacters }
})

export default useCharacterStore

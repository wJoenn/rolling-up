import { defineStore } from "pinia"
import axios from "axios"

const authToken = localStorage.getItem("authToken")

const useCharacterStore = defineStore("CharacterStore", () => {
  const getCharacters = async () => {
    try {
      const res = await axios.get("http://localhost:3000/characters", { headers: { Authorization: authToken } })

      const characters = JSON.parse(res.data.characters)
      return characters
    } catch {
      return []
    }
  }

  return { getCharacters }
})

export default useCharacterStore

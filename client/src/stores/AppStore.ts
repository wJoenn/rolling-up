import { computed, ref } from "vue"
import { defineStore } from "pinia"
import axios from "axios"

const useAppStore = defineStore("AppStore", () => {
  const digits = computed(() => Array.from(String(total.value), Number))

  const total = ref(0)

  const getTotalCharactersCreated = async () => {
    try {
      const res = await axios.get("http://localhost:3000/characters/total")
      total.value = res.data.total
    } catch (err) {
      // Error's handled in component
    }
  }

  return { digits, total, getTotalCharactersCreated }
})

export default useAppStore

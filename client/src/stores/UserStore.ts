import { computed, ref } from "vue"
import { defineStore } from "pinia"
import axios from "axios"

import handleApiErrors from "../composables/handleApiErrors.ts"

interface Params {
  user: {
    email: string
    password: string
    password_confirmation?: string
  }
}

interface User {
  id: number | null
  email: string | null
  created_at: string | null
  updated_at: string | null
}

const useUserStore = defineStore("UserStore", () => {
  const authToken = ref<string | null>(null)

  const errors = ref<string[]>([])

  const user = ref<User>({
    id: null,
    email: null,
    created_at: null,
    updated_at: null
  })

  const isLoggedIn = computed<boolean>(() => {
    const loggedOut = authToken.value === null || authToken.value === JSON.stringify(null)

    return !loggedOut
  })

  const login = (params: Params): Promise<boolean> => postRequest("/users/sign_in", params)

  const loginUserWithToken = async (token: string) => {
    try {
      const res = await axios.get("http://localhost:3000/current_user", { headers: { Authorization: token } })

      updateAuthToken(localStorage.getItem("authToken") as string)
      updateUser(res.data.user)
    } catch (err: any) {
      errors.value = handleApiErrors(err)
    }
  }

  const logout = async () => {
    try {
      await axios.delete("http://localhost:3000/users/sign_out", { headers: { Authorization: authToken.value } })

      reset()
    } catch (err: any) {
      errors.value = handleApiErrors(err)
    }
  }

  const signup = (params: Params): Promise<boolean> => postRequest("/users", params)

  // Private

  const postRequest = async (endPoint: string, params: Params): Promise<boolean> => {
    try {
      const res = await axios.post(
        `http://localhost:3000${endPoint}`,
        params,
        { headers: { "Content-Type": "application/json" } }
      )

      updateAuthToken(res.headers.authorization)
      updateUser(res.data.user)

      return true
    } catch (err: any) {
      errors.value = handleApiErrors(err)

      return false
    }
  }

  const reset = () => {
    authToken.value = null
    localStorage.removeItem("authToken")

    user.value = {
      id: null,
      email: null,
      created_at: null,
      updated_at: null
    }
  }

  const updateAuthToken = (auth: string) => {
    authToken.value = auth
    localStorage.setItem("authToken", authToken.value)
  }

  const updateUser = (userData: User) => {
    user.value = userData
  }

  return { authToken, errors, user, isLoggedIn, login, loginUserWithToken, logout, signup }
})

export default useUserStore

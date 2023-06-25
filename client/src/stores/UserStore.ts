import { computed, ref } from "vue"
import { defineStore } from "pinia"
import axios from "axios"

import handleApiErrors from "../composables/handleApiErrors.ts"

const API_URL = import.meta.env.VITE_API_URL

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

  const errors = ref({})

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
      const res = await axios.get(`${API_URL}/current_user`, { headers: { Authorization: token } })

      updateAuthToken(localStorage.getItem("authToken") as string)
      updateUser(res.data.user)
    } catch (err: any) {
      errors.value = handleApiErrors(err)
    }
  }

  const logout = async () => {
    try {
      await axios.delete(`${API_URL}/users/sign_out`, { headers: { Authorization: authToken.value } })

      reset()
    } catch (err: any) {
      errors.value = handleApiErrors(err)
    }
  }

  const resetErrors = () => {
    errors.value = {}
  }

  const signup = (params: Params): Promise<boolean> => postRequest("/users", params)

  // Private

  const postRequest = async (endPoint: string, params: Params): Promise<boolean> => {
    try {
      const res = await axios.post(
        `${API_URL}${endPoint}`,
        params,
        { headers: { "Content-Type": "application/json" } }
      )

      updateAuthToken(res.headers.authorization)
      updateUser(res.data.user)

      return true
    } catch (err: any) {
      errors.value = handleApiErrors(err, "email", "confirmation", "password")

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

  return { authToken, errors, user, isLoggedIn, login, loginUserWithToken, logout, resetErrors, signup }
})

export default useUserStore

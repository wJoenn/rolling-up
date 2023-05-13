import { computed, ref } from "vue"
import { defineStore } from "pinia"
import axios from "axios"

interface ApiResponseUser {
  id: number
  email: string
  created_at: string | Date
  updated_at: string | Date
}

interface RegistrationParams {
  user: {
    email: string
    password: string
    password_confirmation: string
  }
}

interface SessionParams {
  user: {
    email: string
    password: string
  }
}

interface User {
  id: number | null
  email: string | null
  created_at: Date | null
  updated_at: Date | null
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

  const login = (params: SessionParams): Promise<boolean> => postRequest("/users/sign_in", params)

  const loginUserWithToken = async (token: string) => {
    try {
      const res = await axios.get("http://localhost:3000/current_user", { headers: { Authorization: token } })

      updateAuthToken(localStorage.getItem("authToken") as string)
      updateUser(res.data.user)
    } catch (err: any) {
      handleError(err)
    }
  }

  const logout = async () => {
    try {
      await axios.delete("http://localhost:3000/users/sign_out", { headers: { Authorization: authToken.value } })

      reset()
    } catch (err: any) {
      handleError(err)
    }
  }

  const signup = (params: RegistrationParams): Promise<boolean> => postRequest("/users", params)

  // Private

  const handleError = (error: any) => {
    let message: string = error.message
    if (error.response.data.errors) errors.value = error.response.data.errors
    if (error.response.data.message) message = error.response.data.message

    console.log(`An error occured: ${message} ${errors.value.join(", ")}`) // eslint-disable-line no-console
  }

  const postRequest = async (endPoint: string, params: SessionParams | RegistrationParams): Promise<boolean> => {
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
      handleError(err)

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

  const updateUser = (userData: ApiResponseUser) => {
    userData.created_at = new Date(userData.created_at)
    userData.updated_at = new Date(userData.updated_at)
    user.value = userData as User
  }

  return { authToken, errors, user, isLoggedIn, login, loginUserWithToken, logout, signup }
})

export default useUserStore

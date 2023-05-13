import { createApp } from "vue"
import { createPinia } from "pinia"

import App from "./App.vue"
import router from "./router/router.ts"
import useSessionStore from "./stores/UserStore.ts"
import "./assets/stylesheets/application.scss"

const app = createApp(App)
const pinia = createPinia()

const loadAuthToken = async () => {
  const authToken = localStorage.getItem("authToken")
  const authTokenExists = authToken !== "undefined" && authToken !== null

  if (authTokenExists) {
    await useSessionStore(pinia).loginUserWithToken(authToken)
  }
}

loadAuthToken().then(() => {
  app
    .use(router)
    .use(pinia)
    .mount("#app")
})

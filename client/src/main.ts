import { createApp } from "vue"
import { createPinia } from "pinia"

import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome"
import { library } from "@fortawesome/fontawesome-svg-core"
import {
  faBars, faChevronLeft, faDragon, faEye, faEyeSlash, faPlus
} from "@fortawesome/free-solid-svg-icons"

import App from "./App.vue"
import router from "./router/router.ts"
import useSessionStore from "./stores/UserStore.ts"
import "./assets/stylesheets/application.scss"

const app = createApp(App)
const pinia = createPinia()

library.add(faBars, faChevronLeft, faDragon, faEye, faEyeSlash, faPlus)

const loadAuthToken = async () => {
  const authToken = localStorage.getItem("authToken")
  const authTokenExists = authToken !== "undefined" && authToken !== null

  if (authTokenExists) {
    await useSessionStore(pinia).loginUserWithToken(authToken)
  }
}

loadAuthToken().then(() => {
  app
    .component("fai", FontAwesomeIcon) // eslint-disable-line vue/component-definition-name-casing
    .use(router)
    .use(pinia)
    .mount("#app")
})

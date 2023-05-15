import { createRouter, createWebHistory } from "vue-router"

import Home from "../views/Home.vue"
import UserForm from "../views/UserForm.vue"

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home
  },
  {
    path: "/users/:action",
    name: "UserForm",
    component: UserForm,
    props: true
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router

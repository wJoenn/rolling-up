import { NavigationGuardNext, RouteLocationNormalized, createRouter, createWebHistory } from "vue-router"
import useUserStore from "../stores/UserStore.ts"

import Home from "../views/Home.vue"
import UserForm from "../views/UserForm.vue"
import CharactersIndex from "../views/characters/Index.vue"
import CharacterShow from "../views/characters/Show.vue"
import CharactersNew from "../views/characters/New.vue"

const verifyAuthentification = (to: RouteLocationNormalized, next: NavigationGuardNext) => {
  const isLoggedIn = useUserStore().isLoggedIn
  const requiresAuth = to.meta.requiresAuth

  if (isLoggedIn && !requiresAuth) return next({ name: "CharactersIndex" })
  if (!isLoggedIn && requiresAuth) return next({ name: "Home" })

  return next()
}

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
    meta: { requiresAuth: false }
  },
  {
    path: "/users/:action",
    name: "UserForm",
    component: UserForm,
    props: true,
    meta: { requiresAuth: false }
  },
  {
    path: "/users/logout",
    name: "Logout",
    component: Home,
    meta: { requiresAuth: true },
    beforeEnter: async () => {
      await useUserStore().logout()
    }
  },
  {
    path: "/characters",
    name: "CharactersIndex",
    component: CharactersIndex,
    meta: { requiresAuth: true }
  },
  {
    path: "/characters/:id",
    name: "CharactersShow",
    component: CharacterShow,
    props: true,
    meta: { requiresAuth: true }
  },
  {
    path: "/characters/new",
    name: "CharactersNew",
    component: CharactersNew,
    meta: { requiresAuth: true }
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, _from, next) => {
  verifyAuthentification(to, next)
})

export default router

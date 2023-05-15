import { Ref } from "vue"

const togglePassword = (show: Ref<boolean>) => {
  show.value = !show.value

  const inputs = document.querySelectorAll(".passwordInput") as NodeListOf<HTMLInputElement>
  inputs.forEach(i => { i.type = show.value ? "text" : "password" })
}

export default togglePassword

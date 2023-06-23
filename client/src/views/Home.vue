<template>
  <div id="home" class="container">
    <div>
      <div class="gif"><div /></div>

      <div class="title">
        <h1>Rollingup</h1>
        <p>
          Welcome to the best DnD character creation assistant.
          Create an account and access your characters anytime.
        </p>
      </div>
    </div>

    <div class="buttons">
      <router-link :to="{ name: 'UserForm', params: { action: 'sign_in' } }" class="btn btn-purple">
        <span>LOG IN</span>
        <fai icon="fa-solid fa-dragon" />
      </router-link>

      <router-link :to="{ name: 'UserForm', params: { action: 'sign_up' } }" class="btn btn-purple">
        <span>CREATE AN ACCOUNT</span>
        <fai icon="fa-solid fa-dragon" />
      </router-link>
    </div>

    <div v-if="total > 0" class="counter">
      <ul>
        <li v-for="digit in digits" :key="digit">{{ digit }}</li>
      </ul>
      <p>characters brought to life so far</p>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { computed, onMounted, ref } from "vue"
  import axios from "axios"

  const total = ref(0)

  const digits = computed(() => Array.from(String(total.value)))

  const getTotalCharactersCreated = async () => {
    try {
      const res = await axios.get(`${import.meta.env.VITE_API_URL}/characters/total`)
      total.value = res.data.total as number
    } catch {
      // Error's handled in component
    }
  }

  onMounted(() => {
    getTotalCharactersCreated()
  })
</script>

<style scoped lang="scss">
@keyframes jump {
  0% {
    translate: 0 0;
  }

  50% {
    translate: 0 -3%;
  }

  100% {
    translate: 0 0;
  }
}

@keyframes pulse-rotate {
  0% {
    rotate: 0deg;
    scale: 1;
  }

  50% {
    rotate: 180deg;
    scale: 0.98;
  }

  100% {
    rotate: 360deg;
    scale: 1;
  }
}

#home {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  min-height: 100svh;
  text-align: center;

  h1 {
    font-size: 60px;
    margin-bottom: 20px;
  }

  .buttons {
    display: flex;
    flex-direction: column;
    font-weight: 700;
    gap: 20px;
  }

  .counter {
    display: flex;
    flex-direction: column;
    gap: 10px;

    p {
      font-size: 0.8rem;
    }

    ul {
      display: flex;
      justify-content: center;
      gap: 10px;

      li {
        align-items: center;
        background-color: $darkgrey;
        border-radius: 5px;
        display: flex;
        font-size: 30px;
        font-weight: 700;
        height: 45px;
        justify-content: center;
        width: 35px;
      }
    }
  }

  .gif {
    animation: jump 2s linear infinite;

    div {
      aspect-ratio: 1/1;
      background-image: url("../assets/images/dice.png");
      background-size: cover;
      width: 100%;
      position: relative;

      &::before {
        animation: pulse-rotate 10s linear infinite;
        background-image: linear-gradient(225deg, rgb(68, 208, 243), rgb(204, 52, 204));
        border-radius: 50%;
        content: "";
        filter: blur(20px);
        height: 100%;
        opacity: 0.3;
        position: absolute;
        right: 0;
        top: 0;
        width: 100%;
        z-index: -10;
      }
    }
  }

  .title {
    translate: 0 -30px;
  }
}
</style>

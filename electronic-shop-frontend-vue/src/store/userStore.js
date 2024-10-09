// userStore.js
import { defineStore } from 'pinia';

export default defineStore('user', {
    state: () => ({
      user: null,
    }),
    actions: {
      setUser(user) {
        this.user = user;
      },
    },
  });

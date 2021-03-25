import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import axios from "axios";
import "./plugins/element";

Vue.config.productionTip = false;

axios.defaults.baseURL =
  process.env.NODE_ENV === "production" ? "" : `http://localhost:5000`;

new Vue({
  router,
  render: h => h(App)
}).$mount("#app");

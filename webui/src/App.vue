<template>
  <div id="app">
    <el-card class="box-card" style="margin-top: 60px;">
      <div slot="header" class="clearfix">
        <span>Роли</span>
      </div>
      <el-checkbox-group v-model="role" @change="updateRole" style="text-align: left;">
        <el-checkbox
          v-for="r in roleVariant"
          :label="r.id"
          :key="r.id"
          v-model="role"
          style="display: block;"
        >{{ r.name }}</el-checkbox>
      </el-checkbox-group>
    </el-card>
    <el-button-group style="margin-top: 20px;">
      <router-link v-for="p in avaibleProductTop" :key="p.id" :to="'/'+p.linkName">
        <el-button  type="primary" style="margin: 6px;">{{ p.name }}</el-button>
      </router-link>
    </el-button-group>
    <router-view v-if="role.length > 0" :key="$route.path" style="margin-top: 20px;"/>
  </div>
</template>

<script>
import ProductTop from './views/ProductTop.vue'

export default {
  name: 'app',
  data() {
    return {
      productTopVariant: [],
      roleVariant: [],
      role: []
    }
  },
  computed: {
    avaibleProductTop() {
      return this.productTopVariant.filter(p => this.role.includes(p.id));
    }
  },
  methods: {
    updateRole() {
      this.$axios
        .put("/api/Role", this.role);
    }
  },
  created() {
    this.$axios
      .get("/api/ProductTopVariant")
      .then(res => {
        this.productTopVariant = res.data;
      
        res.data.map(p => {
          this.$router.addRoutes([{
            path: '/'+p.linkName,
            name: 'Index-'+p.id,
            component: ProductTop,
            props: { id: p.id, name: p.name }
          }]);
          //this.$router.push(p.linkName);
        });

        console.log(this.$router.currentRoute.path.substr(1));
      });
    this.$axios
      .get("/api/RoleVariant")
      .then(res => {
        this.roleVariant = res.data;
      });
    this.$axios
      .get("/api/Role")
      .then(res => {
        this.role = res.data;
      });
  }
}
</script>

<style>
html, body, #app {
  height: 100%;
  width: 100%;
  margin: 0;
  padding: 0;
}
body {
  display: grid;
}
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  width: 600px;
  justify-self: center;
}
</style>

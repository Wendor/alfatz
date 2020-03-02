<template>
  <div id="app">
    <el-card class="box-card" style="margin-top: 60px;">
      <div slot="header" class="clearfix">
        <span>Роли</span>
      </div>
      <el-checkbox-group v-model="userRole" @change="updateUserRole" style="text-align: left;">
        <el-checkbox
          v-for="r in role"
          :label="r.id"
          :key="r.id"
          v-model="userRole"
          style="display: block;"
        >{{ r.name }}</el-checkbox>
      </el-checkbox-group>
    </el-card>
    <el-button-group style="margin-top: 20px;">
      <router-link v-for="p in avaibleReport" :key="p.id" :to="{ name: 'Report-'+p.id }">
        <el-button :type="p.id == currentReportId ? 'primary' : ''" style="margin: 6px;">{{ p.name }}</el-button>
      </router-link>
    </el-button-group>
    <router-view v-if="userRole.length > 0" :key="$route.fullPath" style="margin-top: 20px;" />
  </div>
</template>

<script>
import Report from "./views/Report.vue";

export default {
  name: "app",
  data() {
    return {
      report: [],
      role: [],
      userRole: []
    };
  },
  computed: {
    avaibleReport() {
      return this.report.filter(p => this.userRole.includes(p.id));
    },
    currentReportId() {
      if (this.$route.matched.length == 1) {
        const route = this.$route.matched[0];
        return route.props.default.id;
      }
      return 0;
    }
  },
  methods: {
    updateUserRole() {
      this.$axios.put("/api/UserRole", this.userRole);
      if (
        this.userRole.length > 0 &&
        this.currentReportId &&
        !this.userRole.includes(this.currentReportId)
      ) {
        this.$router.push("/");
      }
    }
  },
  created() {
    this.$axios.get("/api/Report").then(res => {
      this.report = res.data;

      res.data.map(p => {
        this.$router.addRoutes([
          {
            path: "/" + p.linkName,
            name: "Report-" + p.id,
            component: Report,
            props: { id: p.id, name: p.name }
          }
        ]);
      });
    });
    this.$axios.get("/api/Role").then(res => {
      this.role = res.data;
    });
    this.$axios.get("/api/UserRole").then(res => {
      this.userRole = res.data;
    });
  }
};
</script>

<style>
html,
body,
#app {
  height: 100%;
  width: 100%;
  margin: 0;
  padding: 0;
}
body {
  display: grid;
}
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  width: 600px;
  justify-self: center;
}
</style>

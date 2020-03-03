<template>
  <div id="app" v-loading="loading">
    <div v-if="!loading">
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>Роли</span>
        </div>
        <el-checkbox-group class="checks" v-model="userRole" @change="updateUserRole">
          <el-checkbox
            v-for="r in role"
            :label="r.id"
            :key="r.id"
            v-model="userRole"
            style="display: block;"
          >{{ r.name }}</el-checkbox>
        </el-checkbox-group>
      </el-card>
      <el-button-group class="btns">
        <router-link v-for="p in avaibleReport" :key="p.id" :to="{ name: 'Report-'+p.id }">
          <el-button class="tabButton" :type="p.id == currentReportId ? 'primary' : ''">{{ p.name }}</el-button>
        </router-link>
      </el-button-group>
      <router-view class="report" v-if="userRole.length > 0" :key="$route.fullPath" />
    </div>
  </div>
</template>

<script>
import Report from "./views/Report.vue";

export default {
  name: "app",
  data() {
    return {
      loading: true,
      report: [],
      role: [],
      userRole: []
    };
  },
  computed: {
    // Вычисляет массив доступных отчетов согласно ролям
    avaibleReport() {
      return this.report.filter(p => this.userRole.includes(p.id));
    },
    // Вычисляет ID открытого в настоящий момент отчета
    currentReportId() {
      if (this.$route.matched.length == 1) {
        const route = this.$route.matched[0];
        return route.props.default.id;
      }
      return 0;
    }
  },
  methods: {
    // Отправка ролей на сохранение
    updateUserRole() {
      this.$axios.put("/api/UserRole", this.userRole);

      // Если сейчас открыт отчет, на который
      // права забрали - закрыть отчет
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
    Promise.all([
      // Загрузка списка возможных отчетов
      this.$axios.get("/api/Report").then(res => {
        this.report = res.data;

        // Добавление отчетов в роутер
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
      }),

      // Загрузка возможных ролей
      this.$axios.get("/api/Role").then(res => {
        this.role = res.data;
      }),

      // Загрузка ролей пользователя
      this.$axios.get("/api/UserRole").then(res => {
        this.userRole = res.data;
      })
    ])
    .then(() => this.loading = false)
    .catch(() => this.loading = false);
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
#app .box-card {
  margin-top: 60px;
}
.box-card .checks {
  text-align: left;
}
#app .btns {
  margin-top: 20px;
}
#app .btns .tabButton {
  margin: 6px;
}
#app .report {
  margin-top: 20px;
}
</style>

<template>
  <div id="app" v-loading="loading">
    <div v-if="!loading && !errorText">
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

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';
import Report from "./views/Report.vue";
import { ReportVariant } from './types/report-veriant';
import { Role } from './types/role';

export default Vue.extend({
  name: "app",
  data(): {
    loading: boolean;
    errorText: string;
    report: ReportVariant[];
    role: Role[];
    userRole: number[];
  } {
    return {
      loading: true,
      errorText: "",
      report: [],
      role: [],
      userRole: [],
    };
  },
  computed: {
    // Вычисляет массив доступных отчетов согласно ролям
    avaibleReport(): ReportVariant[] {
      return this.report.filter((r: ReportVariant) => this.userRole.includes(r.id));
    },
    // Вычисляет ID открытого в настоящий момент отчета
    currentReportId(): number {
      if (this.$route.matched.length == 1) {
        const props = this.$route.matched[0].props as { default: ReportVariant };
        const current = props.default;
        return current.id;
      }
      return 0;
    }
  },
  methods: {
    // Отправка ролей на сохранение
    updateUserRole(): void {
      axios.put("/api/UserRole", this.userRole);

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
  created(): void {
    Promise.all([
      // Загрузка списка возможных отчетов
      axios.get("/api/Report").then(res => {
        this.report = res.data;

        // Добавление отчетов в роутер
        res.data.forEach((p: ReportVariant) => {
          const name = "Report-" + p.id;
          const exists = this.$router.getRoutes().findIndex(r => r.name === name);
          if (exists === -1) {
            this.$router.addRoute({
              path: "/" + p.linkName,
              name,
              component: Report,
              props: p,
            });
          }
        });
      }),

      // Загрузка возможных ролей
      axios.get("/api/Role").then(res => this.role = res.data),

      // Загрузка ролей пользователя
      axios.get("/api/UserRole").then(res => this.userRole = res.data),

    ])
    .then(() => this.loading = false)
    .catch((e) => {
      this.loading = false;
      this.errorText = e;
      this.$message({
        message: e,
        type: 'error',
        duration: 0
      });
    });
  }
});
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

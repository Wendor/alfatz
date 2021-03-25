<template>
  <el-card class="box-card" v-loading="loading">
    <div slot="header" class="clearfix">
      <span>{{ name }}</span>
    </div>
    <el-table :data="tableData" size="mini" :empty-text="emptyTextWithLoading">
      <el-table-column prop="id" label="Id" width="60"></el-table-column>
      <el-table-column prop="name" label="Название" width="300"></el-table-column>
      <el-table-column prop="cost" label="Цена" width="80"></el-table-column>
      <el-table-column prop="buys" label="Продажи" width="80"></el-table-column>
    </el-table>
  </el-card>
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';
import { ReportRecord } from '../types/report-record';

export default Vue.extend({
  name: "Report",
  props: ["id", "name"],
  data(): {
    loading: boolean;
    tableData: ReportRecord[];
    emptyText: string;
  } {
    return {
      loading: true,
      tableData: [],
      emptyText: "Нет данных для отображения"
    };
  },
  computed: {
    emptyTextWithLoading(): string {
      return this.loading ? " " : this.emptyText;
    }
  },
  mounted(): void {
    axios
      .get("/api/GenerateReport/" + this.id)
      .then(res => {
        this.tableData = res.data;
        this.loading = false;
      })
      .catch(e => {
        this.emptyText = e.toString();
        this.loading = false;
      });
  }
});
</script>

<style>
.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both;
}
</style>

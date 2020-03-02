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

<script>
export default {
  name: "Report",
  props: ["id", "name"],
  data() {
    return {
      loading: true,
      tableData: [],
      emptyText: "Нет данных для отображения"
    };
  },
  computed: {
    emptyTextWithLoading() {
      return this.loading ? " " : this.emptyText;
    }
  },
  mounted() {
    this.$axios
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
};
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
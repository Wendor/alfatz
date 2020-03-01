<template>
  <div>
    <el-card class="box-card">
      <el-table :data="tableData" :loading="loading" size="mini" :empty-text="emptyText">
        <el-table-column prop="id" label="Id" width="60"></el-table-column>
        <el-table-column prop="name" label="Название" width="300"></el-table-column>
        <el-table-column prop="cost" label="Цена" width="80"></el-table-column>
        <el-table-column prop="buys" label="Продажи" width="80"></el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'ProductTop',
  props: ["id", "name"],
  data() {
    return {
      loading: true,
      tableData: [],
      emptyText: "Нет данных для отображения"
    }
  },
  mounted() {
    this.$axios
      .get("/api/ProductTop/"+this.id)
      .then(res => {
        this.tableData = res.data;
        this.loading = false;
      })
      .catch(e => {
        this.emptyText = e.toString();
        this.loading = false;
      });
  }
}

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
    clear: both
  }
</style>
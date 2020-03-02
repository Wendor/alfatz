module.exports = {
  runtimeCompiler: true,
  productionSourceMap: false,

  publicPath: process.env.NODE_ENV === 'production' ? './' : '/',
  
  devServer: {
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
    },
    proxy: {
      '^/api': {
        target: 'http://localhost:5000/',
        ws: true,
        changeOrigin: true
      },
    }
  },   
}

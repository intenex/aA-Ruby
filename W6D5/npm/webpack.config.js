const path = require('path');

module.exports = {
  entry: './app.jsx',
  output: {
    path: path.resolve(__dirname), // love it this is what you need yep
    filename: './bundle.js',
  },
  module: {
    rules: [
      {
        test: [/\.jsx?$/, /\.js?$/],
        exclude: /(node_modules)/,
        use: {
          loader: 'babel-loader',
          query: {
            presets: ['@babel/env', '@babel/react']
          }
        },
      }
    ]
  },
  devtool: 'source-map',
  resolve: {
    extensions: ['*', '.js', '.jsx']
  }
};
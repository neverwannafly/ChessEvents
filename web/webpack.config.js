// eslint-disable-next-line no-unused-vars
const webpack = require('webpack');
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

const port = process.env.PORT || 3000;

module.exports = {
  output: {
    path: path.join(__dirname, '/dist'), // the bundle output path
    filename: 'bundle.[fullhash].js',
    chunkFilename: '[id].[hash].js',
    publicPath: '/',
  },
  mode: 'development',
  devtool: 'inline-source-map',
  entry: './src/index.js',
  plugins: [
    new HtmlWebpackPlugin({
      template: 'public/index.html', // to import index.html file inside index.js
      favicon: 'public/favicon.ico',
    }),
  ],
  resolve: {
    alias: {
      '@app': path.resolve(__dirname, 'src'),
    },
    extensions: ['.js', '.jsx'],
  },
  devServer: {
    host: 'localhost',
    port,
    historyApiFallback: true,
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/, // .js and .jsx files
        exclude: /node_modules/, // excluding the node_modules folder
        use: {
          loader: 'babel-loader',
        },
      },
      {
        test: /\.(sa|sc|c)ss$/, // styles files
        use: ['style-loader', 'css-loader', 'sass-loader'],
      },
      {
        test: /\.(woff|woff2|eot|ttf|otf)$/i,
        type: 'asset/resource',
      },
      {
        test: /\.(png|jpg|)$/,
        use: {
          loader: 'url-loader?limit=200000',
        },
      },
    ],
  },
};

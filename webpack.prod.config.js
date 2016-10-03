// Very similar to webpack.dev.config.js. Common parts could be extracted to a base config.
// See example at:
// https://github.com/shakacode/react-webpack-rails-tutorial/blob/master/client%2Fwebpack.client.base.config.js
const webpack = require('webpack');

const ExtractTextPlugin = require('extract-text-webpack-plugin');
const path = require('path');
const autoprefixer = require('autoprefixer');
const bootstrapEntryPoints = require('./webpack.bootstrap.config.js');

// eslint-disable-next-line no-console
console.log(`=> bootstrap-loader configuration: ${bootstrapEntryPoints.prod}`);

module.exports = {

  // For production build we want to extract CSS to stand-alone file
  // Provide `extractStyles` param and `bootstrap-loader` will handle it
  entry: [
    'font-awesome-loader',
    bootstrapEntryPoints.prod,
    //'animate-css-webpack!./animate-css.config.js',
    //'tether',
    './app/scripts/app',
  ],

  output: {
    path: path.join(__dirname, 'public', 'assets'),
    filename: 'app.js',
  },

  resolve: {
    extensions: ['', '.js']
  },

  plugins: [
    new ExtractTextPlugin({
      filename: 'app.css',
      allChunks: true
    })
  ],

  module: {
    loaders: [{
        test: /\.css$/,
        loader: ExtractTextPlugin.extract({
          fallbackLoader: 'style',
          loader: 'css!postcss',
        })
      }, {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract({
          fallbackLoader: 'style',
          loader: 'css!postcss!sass',
        })
      },

      {
        test: /\.woff2?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        // Limiting the size of the woff fonts breaks font-awesome ONLY for the extract text plugin
        // loader: "url?limit=10000"
        loader: 'url',
      }, {
        test: /\.(ttf|eot|svg)(\?[\s\S]+)?$/,
        loader: 'file',
      },

      // Use one of these to serve jQuery for Bootstrap scripts:

      // Bootstrap 4
      {
        test: /bootstrap\/dist\/js\/umd\//,
        loader: 'imports?jQuery=jquery'
      },

      // Bootstrap 3
      {
        test: /bootstrap-sass\/assets\/javascripts\//,
        loader: 'imports?jQuery=jquery'
      },

      {
        test: /\.js$/,
        loader: 'babel-loader',
        exclude: [/node_module/],
        query: {
          'presets': ['es2015']
        }
      }, {
        test: /\.tag$/,
        loader: 'babel-loader!tag',
        exclude: [/node_module/],


      }
    ],
  },

  postcss: [autoprefixer],

};
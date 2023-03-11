'use strict';

const path = require('path');
const fs = require('fs');
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');

const appDirectory = fs.realpathSync(process.cwd());
const resolveApp = (relativePath) => path.resolve(appDirectory, relativePath);

module.exports = {
  mode: 'development',
  context: resolveApp('./src'),
  entry: [
    resolveApp('./src/index.js'),
  ],
  output: {
    pathinfo: true,
    filename: 'static/js/bundle.js',
    chunkFilename: 'static/js/[name].chunk.js',
    publicPath: '/',
  },
  resolve: {
    modules: ['node_modules'],
    extensions: ['.js', '.elm', '.mjs'],
  },
  module: {
    noParse: /\.elm$/,
    strictExportPresence: true,
    rules: [
      { parser: { requireEnsure: false } },

      {
        enforce: 'pre',
        test: /\.s[ac]ss/,
        use: 'import-glob-loader',
      },
      {
        test: /\.m?js$/,
        exclude: [/[/\\\\]elm-stuff[/\\\\]/, /[/\\\\]node_modules[/\\\\]/],
        include: '/',
        loader: require.resolve('babel-loader'),
        options: {
          presets: [
            [
              require.resolve('@babel/preset-env'),
              {
                useBuiltIns: 'entry',
                corejs: 3,
                modules: false,
              },
            ],
          ],
          plugins: [
            [
              require('@babel/plugin-transform-runtime').default,
              {
                helpers: false,
                regenerator: true,
              },
            ],
          ],
        },
      },
      {
        test: /\.m?js$/,
        use: [
          {
            loader: require.resolve('babel-loader'),
            options: {
              babelrc: false,
              compact: false,
              configFile: false,
              presets: [
                [
                  require('@babel/preset-env').default,
                  {
                    modules: false,
                  },
                ],
              ],
              cacheDirectory: true,
              highlightCode: true,
            },
          },
        ],
      },
      {
        test: /\.elm$/,
        include: resolveApp('./src'),
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          {
            loader: require.resolve('elm-hot-webpack-loader'),
            options: {},
          },
          {
            loader: require.resolve('string-replace-loader'),
            options: {
              search: '%PUBLIC_URL%',
              replace: '',
              flags: 'g',
            },
          },
          {
            loader: require.resolve('elm-asset-webpack-loader'),
          },
          {
            loader: require.resolve('elm-webpack-loader'),
            options: {
              debug: true,
              optimize: false,
              cwd: resolveApp('.'),
              pathToElm: require.resolve('elm/bin/elm'),
              runtimeOptions: ['-A128M', '-H128M', '-n8m'],
            },
          },
        ],
      },
      {
        exclude: [
          /\.html$/,
          /\.js$/,
          /\.mjs$/,
          /\.elm$/,
          /\.css$/,
          /\.json$/,
          /\.svg$/,
        ],
        loader: require.resolve('url-loader'),
        options: {
          limit: 10000,
          name: 'static/media/[name].[hash:8].[ext]',
        },
      },
    ],
  },

  plugins: [
    new HtmlWebpackPlugin({
      inject: true,
      template: resolveApp('./index.html'),
    }),
    new webpack.HotModuleReplacementPlugin()
  ],

  performance: false,
  devServer: {
    client: {
      logging: 'info',
      overlay: true,
      progress: false,
      webSocketURL: 'ws://localhost:8000/ws',
    },
    webSocketServer: 'ws',
    compress: true,
    historyApiFallback: true,
    hot: true,
    liveReload: true,
    static: {
      directory: resolveApp('.'),
      publicPath: '/',
      watch: {
        poll: true,
        ignored: /node_modules/,
      },
    },
    https: false,
    host: '0.0.0.0',
    open: true,
    port: 8000,
  },
};

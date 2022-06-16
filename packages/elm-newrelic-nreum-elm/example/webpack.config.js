'use strict';

const path = require('path');
const fs = require('fs');
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const extractMiniCss = new MiniCssExtractPlugin({
  filename: 'src/[name].css',
});

const appDirectory = fs.realpathSync(process.cwd());
const resolveApp = (relativePath) => path.resolve(appDirectory, relativePath);

module.exports = {
  mode: 'development',
  entry: [
    resolveApp('./src/index.js'),
  ],
  output: {
    pathinfo: true,
    filename: 'static/js/bundle.js',
    chunkFilename: 'static/js/[name].chunk.js',
    publicPath: '',
  },
  resolve: {
    modules: ['node_modules'],
    extensions: ['.js', '.elm', '.scss', '.mjs'],
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
        test: /\.s[ac]ss$/,
        use: [
          { loader: MiniCssExtractPlugin.loader },
          { loader: require.resolve('css-loader') },
          {
            loader: require.resolve('postcss-loader'),
            options: {
              postcssOptions: {
                plugins: ['autoprefixer'],
              }
            },
          },
          {
            loader: require.resolve('sass-loader'),
            options: {
              implementation: require('node-sass'),
              sourceMap: false,
              sassOptions: {
                indentedSyntax: false,
              },
            },
          },
        ],
      },
      {
        test: /\.m?js$/,
        exclude: [/[/\\\\]elm-stuff[/\\\\]/, /[/\\\\]node_modules[/\\\\]/],
        include: resolveApp('./src/'),
        loader: require.resolve('babel-loader'),
        options: {
          presets: [
            [
              require.resolve('@babel/preset-env'),
              {
                // `entry` transforms `@babel/polyfill` into individual requires for
                // the targeted browsers. This is safer than `usage` which performs
                // static code analysis to determine what's required.
                // This is probably a fine default to help trim down bundles when
                // end-users inevitably import '@babel/polyfill'.
                useBuiltIns: 'entry',
                corejs: 3,
                // Do not transform modules to CJS
                modules: false,
              },
            ],
          ],
          plugins: [
            // Polyfills the runtime needed for async/await and generators
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
      // Process any JS outside of the app with Babel.
      // Unlike the application JS, we only compile the standard ES features.
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
                  // Latest stable ECMAScript features
                  require('@babel/preset-env').default,
                  {
                    // Do not transform modules to CJS
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
        include: resolveApp('./src/'),
        exclude: [/[/\\\\]elm-stuff[/\\\\]/, /[/\\\\]node_modules[/\\\\]/],
        use: [
          {
            loader: require.resolve('elm-hot-webpack-loader'),
          },
          {
            loader: require.resolve('string-replace-loader'),
            query: {
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
              verbose: true,
              // If ELM_DEBUGGER was set to "false", disable it. Otherwise
              // for invalid values, "true" and as a default, enable it
              debug: true,
              pathToElm: require.resolve('elm/bin/elm'),
              forceWatch: true,
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
          /\.scss$/,
          /\.sass$/,
          /\.json$/,
          /\.svg$/,
        ],
        loader: require.resolve('url-loader'),
        options: {
          limit: 10000,
          name: 'static/media/[name].[hash:8].[ext]',
        },
      },

      {
        test: /\.(jpg|svg|png|gif)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: require.resolve('file-loader'),
        options: { name: 'static/media/[name].[hash:8].[ext]' }
      },
    ],
  },

  plugins: [
    extractMiniCss,
    new HtmlWebpackPlugin({
      inject: true,
      template: resolveApp('./index.html'),
    }),
    new webpack.HotModuleReplacementPlugin()
  ],

  performance: false,
  watch: true,

  devServer: {
    inline: true,
    hot: true,
    stats: 'errors-only'
  }
};

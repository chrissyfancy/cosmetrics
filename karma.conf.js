var path = require('path');

module.exports = function(config) {
  config.set({
    browsers: ['PhantomJS'],

    frameworks: ['jasmine'],

    files: [
      '../node_modules/babel-polyfill/dist/polyfill.js',
      './test/testHelper.js',

      '../node_modules/whatwg-fetch/fetch.js'
    ],

    preprocessors: {
      '../react/test/testHelper.js': [
        'webpack',
        'sourcemap'
      ]
    },

    webpack: {
      devtool: 'eval-source-map',
      externals: {
        'cheerio': 'window',
        'react/addons': true,
        'react/lib/ExecutionEnvironment': true,
        'react/lib/ReactContext': true
      },
      module: {
        loaders: [
          {
            test: /\.jsx?$/,
            exclude: /node_modules/,
            loader: 'babel-loader'
          },
          {
            test: /\.jsx?$/,
            exclude: /(node_modules|test)/,
            loader: 'isparta-loader'
          },

          {
            include: /\.json$/,
            loader: 'json-loader'
          }
        ]
      },

      resolve: {
        modules: ['src', 'node_modules']
      }
    },

    webpackMiddleware: {
      noInfo: true
    },

    reporters: [
      'spec',
      'coverage'
    ],

    specReporter: {
      maxLogLines: 1,
      suppressPassed: true
    },

    coverageReporter: {
      dir: 'coverage',
      subdir: '.',
      type: 'html'
    }
  })
}

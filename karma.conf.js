module.exports = function(config) {
  config.set({
    basePath: '',
    frameworks: ['jasmine'],
    files: [
      'app/javascript/react/test/testHelper.js',
    ],

    exclude: [
    ],

    preprocessors: {
      'app/javascript/react/test/testHelper.js': ['webpack']
    },

    webpack: {
      module: {
        loaders: [
          {
            test: /\.jsx?/,
            exclude: /node_modules/,
            loader: 'babel-loader'
          }
        ]
      },
      externals: {
        cheerio: 'window',
        'react/addons': 'react',
        'react/lib/ExecutionEnvironment': 'react',
        'react/lib/ReactContext': 'react',
        'react-addons-test-utils': 'react-dom',
      }
    },

    reporters: ['progress'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ['Chrome'],
    singleRun: false,
    concurrency: Infinity
  })
}

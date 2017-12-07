// Karma configuration
// Generated on Thu Feb 13 2014 14:54:33 GMT+0000 (GMT)

module.exports = function(config) {
  config.set({

    // base path, that will be used to resolve files and exclude
    basePath: '..',


    // frameworks to use
    frameworks: ['jasmine'],


    // list of files / patterns to load in the browser
    files: [
     APPLICATION_SPEC,
     'app/assets/javascripts/mortgage_calculator/application.js',
     'app/assets/javascripts/mortgage_calculator/mortgage_calculator_app.js.erb',
     'app/assets/javascripts/mortgage_calculator/angular/**/*.js',
     'spec/javascripts/unit/**/*.js',
     { pattern: 'app/assets/javascripts/mortgage_calculator/angular/**/*.js',
        watched: true,
        included: true,
        served: false },
    { pattern: 'app/assets/javascripts/mortgage_calculator/*.js.erb',
        watched: true,
        included: false,
        served: false }
    ],


    // list of files to exclude
    exclude: [

    ],


    // these plugins will be require() by Karma
    plugins: [
      "karma-growl-reporter",
      'karma-phantomjs-launcher',
      'karma-jasmine'
    ],


    // test results reporter to use
    // possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
    reporters: ['dots', 'growl'],


    // web server port
    port: 9876,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,


    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera (has to be installed with `npm install karma-opera-launcher`)
    // - Safari (only Mac; has to be installed with `npm install karma-safari-launcher`)
    // - PhantomJS
    // - IE (only Windows; has to be installed with `npm install karma-ie-launcher`)
    browsers: ['PhantomJS'],


    // If browser does not capture in given timeout [ms], kill it
    captureTimeout: 60000,


    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: false
  });
};

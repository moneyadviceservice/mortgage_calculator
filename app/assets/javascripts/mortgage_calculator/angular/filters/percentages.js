App
  .filter('percentages', function() {
    return function(input) {
      var rounded = Math.round(input * 100) / 100;
      if (isNaN(rounded)) {
        return '';
      }
      var percentage = '' + rounded + '%';
      return percentage;
    };
  });

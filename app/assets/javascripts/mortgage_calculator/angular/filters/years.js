App
  .filter('years', function() {
    return function(input) {
      if (input)
        return input + ' years';
    };
  });

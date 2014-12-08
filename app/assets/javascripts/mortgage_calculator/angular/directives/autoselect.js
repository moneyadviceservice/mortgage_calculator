'use strict';

App.directive('autoselect', function ($timeout) {
  var linker = function (scope, element, attrs) {
    element.on('focus', function() {
      // Needed to select on iOS.
      $timeout(function() {
        element.select();
        element[0].setSelectionRange(0,99999);
      }, 4);
    });
  };

  return {
    restrict: 'A',
    link: linker
  };
});

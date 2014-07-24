'use strict';

App.directive('ngNoSubmit', function() {
  return {
    restrict: 'A',
    link: function($scope, $element, $attrs, $parse) {
      $element.submit(function() {
        return false;
      });
    }
  };
});

'use strict';

App.directive('integer', function () {
  var linker = function (scope, element, attrs, ctrl) {
    element.on("keypress", function (event) {
      // Keycodes for 0 to 9
      var permittedKeys = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57];

      if ($.inArray(event.keyCode, permittedKeys) >= 0) {
        return true;
      } else {
        event.preventDefault();
        return false;
      }
    });
  };

  var controller = function ($scope) {
  };

  return {
      restrict: 'A',
      require: 'ngModel',
      controller: controller,
      link: linker
  };
});

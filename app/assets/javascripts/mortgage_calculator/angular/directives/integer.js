'use strict';

App.directive('integer', function () {
  var linker = function (scope, element, attrs, ctrl) {
    // we were listening on keychange, however firefox doesn't allow you to edit the number in the textfield.
    element.on("keyup", function (event) {
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

  return {
      restrict: 'A',
      require: 'ngModel',
      link: linker
  };
});

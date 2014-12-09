'use strict';

App.directive('percentage', function () {
  var linker = function (scope, element, attrs, ctrl) {
    ctrl.$parsers.unshift(function (viewValue) {
      if (viewValue) {
        return parseFloat(viewValue.replace(/[^\d|\-+|\.+]/g, ''));
      }
    });

    ctrl.$formatters.unshift(function (valueString) {
      if (valueString) {
        // Cannot use autoNumeric here, it doesn't work with input[type=number]
        return parseFloat(valueString).toFixed(2);
      }
    });
  };

  return {
      restrict: 'A',
      require: 'ngModel',
      link: linker
  };
});

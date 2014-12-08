'use strict';

App.directive('currency', function() {
  var linker = function(scope, element, attrs, ngModel) {
    element.autoNumeric('init');

    if (!ngModel) return;

    ngModel.$render = function () {
      element.autoNumeric('set', (ngModel.$viewValue || ''));
    };

    element.on('change keyup', function () {
      scope.$apply(function () {
        ngModel.$setViewValue(element.val());
      });
    });

    ngModel.$parsers.unshift(function(viewValue) {
      if (viewValue) {
        return parseInt(viewValue.replace(/[^\d|\-+|\.+]/g, ''));
      }
    });

  };

  return {
    restrict: 'A',
    require: '?ngModel',
    link: linker
  };
});

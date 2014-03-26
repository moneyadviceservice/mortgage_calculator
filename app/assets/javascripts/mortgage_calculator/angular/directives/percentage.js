App.directive('percentage', function () {
    var linker = function (scope, element, attrs, ctrl) {
        element.autoNumeric('init');

        ctrl.$parsers.unshift(function (viewValue) {
          if (viewValue) {
            return parseFloat(viewValue.replace(/[^\d|\-+|\.+]/g, ''));
          }
        });

        ctrl.$formatters.unshift(function (a) {
         if (a)
          return element.autoNumeric('set', a).val();
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

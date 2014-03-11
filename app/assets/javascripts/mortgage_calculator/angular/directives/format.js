angular.module('mortgageCalculatorApp')

  .directive('format', ['$filter', function($filter){
    // requires an isloated model
    return {

     restrict: 'A',

     require: 'ngModel',
     link: function(scope, ele, attrs, ctrl){

        ctrl.$formatters.unshift(function (a) {
          return $filter(attrs.format)(ctrl.$modelValue);
        });

        ctrl.$parsers.unshift(function (viewValue) {
          if (viewValue) {
            var plainNumber = viewValue.replace(/[^\d|\-+|\.+]/g, '');
            ele.val($filter('number')(plainNumber));
            return parseInt(plainNumber.replace(/,/g, ''), 10);
          }
        });
     }
    }

  }]);

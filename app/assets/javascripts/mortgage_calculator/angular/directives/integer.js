angular.module('mortgageCalculatorApp')

  .directive('integer', function(){
    return {
        require: 'ngModel',
        link: function(scope, ele, attr, ctrl){
            ctrl.$parsers.unshift(function(viewValue){
                if (viewValue) return parseInt(viewValue.replace(/,/g, ''), 10);
            });
        }
    };
  });

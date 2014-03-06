angular.module('mortgageCalculatorApp')

  .directive("currency", function(){
    // requires an isloated model
    return {
     // restrict to an attribute type.
     restrict: 'A',
    // element must have ng-model attribute.
     require: 'ngModel',
     link: function(scope, ele, attrs, ctrl){

        // add a parser that will process each time the value is
        // parsed into the model when the user updates it.
        ctrl.$parsers.unshift(function(value) {
          if(value){
            // test and set the validity after update.
            var reg = /(?=.)^\$?(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+)?(\.[0-9]{1,2})?$/;
            var valid = reg.test(value);
            ctrl.$setValidity('invalidCurrency', valid);
          }

          // if it's valid, return the value to the model,
          // otherwise return undefined.
          return valid ? value : undefined;
        });

     }
    }

  });

App.directive('percentage', ['$filter', function($filter) {
  var linker = function(scope, element, attrs, ctrl) {

    ctrl.$parsers.unshift(function(viewValue) {
      if (viewValue) {
        return parseFloat(viewValue.replace(/[^\d|\-+|\.+]/g, ''));
      }
    });

    ctrl.$formatters.unshift(function(a) {
      if (a)
        return $filter('percentages')(ctrl.$modelValue);
    });
  };

  var controller = function($scope) {};

  return {
    restrict: 'A',
    require: 'ngModel',
    controller: controller,
    link: linker
  };
}]);


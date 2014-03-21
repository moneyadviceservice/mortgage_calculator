App.directive('percentage', ['$filter', function($filter) {
  var linker = function(scope, element, attrs, ctrl) {

    ctrl.$parsers.unshift(function(viewValue) {
      if (viewValue) {
        var formatted = parseFloat(viewValue.replace(/[^\d|\-+|\.+]/g, ''));
        element.val($filter('percentages')(formatted));
        return formatted;
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


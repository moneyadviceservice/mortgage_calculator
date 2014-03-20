App.directive('year', ['$filter', function($filter) {
  var linker = function(scope, element, attrs, ctrl) {

    ctrl.$parsers.unshift(function(viewValue) {
      if (viewValue) {
        var plainNumber = viewValue.replace(/[^\d|\-+|\.+]/g, '');
        element.val($filter('years')(plainNumber));
        return parseInt(viewValue.replace(/[^\d|\-+|\.+]/g, ''));
      }
    });

    ctrl.$formatters.unshift(function(a) {
      if (a)
        return $filter('years')(ctrl.$modelValue);
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


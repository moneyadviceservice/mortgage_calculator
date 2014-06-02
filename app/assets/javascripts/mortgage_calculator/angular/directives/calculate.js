App.directive('calculate', function() {
  return {
    restrict: 'A',
    controller: [
      '$scope', '$element', '$attrs', '$parse', function($scope, $element, $attrs, $parse) {
        $scope.calculateRepayments();
        $scope.calculateLifestyleSpend();
      }
    ]
  };
});

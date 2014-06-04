'use strict';

App.directive('calculate', function() {
  return {
    restrict: 'A',
    controller: [
      '$scope', function($scope) {
        $scope.calculateRepayments();
        $scope.calculateLifestyleSpend();
      }
    ]
  };
});

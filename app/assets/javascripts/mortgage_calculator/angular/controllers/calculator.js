'use strict';

angular.module('mortgageCalculatorApp')

  .controller('CalculatorCtrl', ['$scope', 'Affordability', function ($scope, Affordability) {

    $scope.affordability = Affordability;
    $scope.affordability.earnings.person1.annual = '';
    $scope.affordability.earnings.person1.extra = '';
    $scope.affordability.selectedOption = $scope.affordability.numberOfPeople[0];

    $scope.normalizeValues = function() {
      if ($scope.affordability.selectedOption === 1 || $scope.affordability.selectedOption === 2) {
        $scope.affordability.earnings.person2.annual = '';
        $scope.affordability.earnings.person2.extra = '';
      }
    };

  }]);

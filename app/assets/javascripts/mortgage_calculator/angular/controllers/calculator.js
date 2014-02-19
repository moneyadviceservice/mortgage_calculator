'use strict';

angular.module('mortgageCalculatorApp')

  .controller('CalculatorCtrl', ['$scope', 'Affordability', function ($scope, Affordability) {

    $scope.affordability = Affordability;
    $scope.affordability.earnings.personOne.annual = '';
    $scope.affordability.earnings.personOne.extra = '';
    $scope.affordability.selectedOption = $scope.affordability.numberOfPeople[0];

    $scope.normalizeValues = function() {
      if ($scope.affordability.selectedOption === 1 || $scope.affordability.selectedOption === 2) {
        $scope.affordability.earnings.personTwo.annual = '';
        $scope.affordability.earnings.personTwo.extra = '';
      }
    };

  }]);

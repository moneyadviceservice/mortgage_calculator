'use strict';

angular.module('mortgageCalculatorApp')

  .controller('CalculatorCtrl', ['$scope', 'Affordability', function ($scope, Affordability) {

    $scope.affordability = Affordability;
    $scope.affordability.selectedOption = $scope.affordability.numberOfPeople[0];

    $scope.normalizeValues = function() {
      if ($scope.affordability.selectedOption === 1) {
        $scope.affordability.personTwoAnnualIncome = 0;
        $scope.affordability.personTwoExtraIncome = 0;
      }
    };

  }]);

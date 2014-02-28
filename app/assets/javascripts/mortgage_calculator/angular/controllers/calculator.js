'use strict';

angular.module('mortgageCalculatorApp')

  .controller('CalculatorCtrl', ['$scope', 'Affordability', 'StampDuty', function ($scope, Affordability, StampDuty) {

    //Affordability Calculations
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


    //Stamp Duty Calculations
    $scope.stampDuty = StampDuty;
    $scope.stampDuty.propertyPrice = '';



  }]);

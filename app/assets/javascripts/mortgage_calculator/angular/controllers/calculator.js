'use strict';

App.controller('CalculatorCtrl', ['$scope', 'Affordability', 'StampDuty', 'Repayments', function ($scope, Affordability, StampDuty, Repayments) {

    $scope.js = true;

    //Affordability Calculations
    $scope.affordability = Affordability;
    $scope.affordability.selectedOption = $scope.affordability.numberOfPeople[0];

    $scope.normalizeValues = function() {
      if ($scope.affordability.selectedOption === 1 || $scope.affordability.selectedOption === 2) {
        $scope.affordability.earnings.person2.annual = 0;
        $scope.affordability.earnings.person2.extra = 0;
      }
    };


    //Stamp Duty Calculations
    $scope.stampDuty = StampDuty;

    //Repayment Calculations
    $scope.repayments = Repayments;

    $scope.viewMonthlyRepayments = true;
    $scope.viewInterestRepayments = false;

    $scope.showMonthly = function() {
      $scope.viewMonthlyRepayments = true;
      $scope.viewInterestRepayments = false;
    };

    $scope.showInterest = function() {
      $scope.viewMonthlyRepayments = false;
      $scope.viewInterestRepayments = true;
    };

    // Show expanded helpers?
    $scope.expandedMortgageInformation = false;
    $scope.toggleExpanded = function($event) {
      $event.preventDefault();
      $scope.expandedMortgageInformation = !$scope.expandedMortgageInformation;
    };

  }]);

'use strict';

App.controller('CalculatorCtrl', ['$scope', 'Affordability', 'StampDuty', 'Repayments', 'WizardHandler', function ($scope, Affordability, StampDuty, Repayments, WizardHandler) {

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
    $scope.repayments.propertyPrice = '';
    $scope.repayments.deposit = '';

    $scope.viewMonthlyRepayments = true;
    $scope.viewInterestRepayments = false;

    $scope.showMonthly = function($event) {
      $event.preventDefault();
      $scope.viewMonthlyRepayments = true;
      $scope.viewInterestRepayments = false;
    };

    $scope.showInterest = function($event) {
      $event.preventDefault();
      $scope.viewMonthlyRepayments = false;
      $scope.viewInterestRepayments = true;
    };

    // Show expanded helpers?
    $scope.expandedMortgageInformation = false;
    $scope.toggleExpanded = function($event) {
      $event.preventDefault();
      $scope.expandedMortgageInformation = !$scope.expandedMortgageInformation;
    };

    // Handle next page keyboard focus
    var focusOnVisibleInput = function() {
      setTimeout(function() {
        $('input[name="repayment[price]"]:visible').focus();
      }, 100);
    };

    $scope.nextAndFocus = function($event) {
      $event.preventDefault();
      WizardHandler.wizard().next();
      
      focusOnVisibleInput();
    };

    // Handle prev page keyboard focus
    $scope.backAndFocus = function($event) {
      $event.preventDefault();
      WizardHandler.wizard().previous();
      
      focusOnVisibleInput();
    };

  }]);

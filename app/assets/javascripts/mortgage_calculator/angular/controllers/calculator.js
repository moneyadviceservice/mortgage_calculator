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


    // All Calculator Helpers
    $scope.preventFormSubmission = function($event) {
      $event.preventDefault();
    };
    $scope.expandedMortgageInformation = false;
    $scope.toggleExpanded = function($event) {
      $event.preventDefault();
      $scope.expandedMortgageInformation = !$scope.expandedMortgageInformation;
    };

    $scope.navigateAndFocus = function($event, direction) {
      $event.preventDefault();
      WizardHandler.wizard()[direction || 'next']();

      // we have no hooks for when angular-wizard has completed its navigation, so we have to wait for a tick
      setTimeout(function() {
        $('input[name="repayment[price]"]:visible').focus();
        $('input[name="stamp_duty[price]"]:visible').focus();
      });
    };

  }]);

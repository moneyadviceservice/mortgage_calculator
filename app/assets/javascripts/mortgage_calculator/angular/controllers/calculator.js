'use strict';

App.controller('CalculatorCtrl', ['$scope', 'Affordability', 'StampDuty', 'Repayments', 'WizardHandler', 'iframeHelpers', function ($scope, Affordability, StampDuty, Repayments, WizardHandler, iframeHelpers) {

    $scope.js = true;

    //Affordability Calculations
    $scope.affordability = Affordability;
    $scope.affordability.selectedOption = $scope.affordability.numberOfPeople[0];

    $scope.isCheckboxSelected = function(index) {
      return index === $scope.affordability.selectedOption;
    };

    $scope.normalizeValues = function() {
      if ($scope.affordability.selectedOption === 1 || $scope.affordability.selectedOption === 2) {
        $scope.affordability.earnings.person2.annual = 0;
        $scope.affordability.earnings.person2.extra = 0;
      }
    };

    $scope.calculateRepayments = function() {
      console.log($scope.affordability.borrowing())
      Repayments.propertyPrice = $scope.affordability.borrowing();
    };

    $scope.calculateLifestyleSpend = function() {
      $scope.affordability.lifestyleSpend = $scope.affordability.calculateLifestyleSpend();
    };

    $scope.borrowingStepValue = ($scope.affordability.borrowing() / 100) * 1;


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

    // Helpers
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
        iframeHelpers.resizeIframe();
        $('input[name="repayment[price]"]:visible').focus();
        $('input[name="stamp_duty[price]"]:visible').focus();
        $('input[name="affordability[interest_rate]"]:visible').focus();
        $('input[name="affordability[people_attributes][0][annual_income]"]:visible').focus();
      });
    };

    iframeHelpers.resizeIframe();
  }]);

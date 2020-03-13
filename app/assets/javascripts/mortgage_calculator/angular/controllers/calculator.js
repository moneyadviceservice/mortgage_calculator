'use strict';

App.controller('CalculatorCtrl', ['$scope', '$window','Affordability', 'StampDuty', 'Repayments', 'WizardHandler', 'iframeHelpers', function ($scope, $window,   Affordability, StampDuty, Repayments, WizardHandler, iframeHelpers) {

console.log('=*=======' );
    //$locationProvider.html5Mode(true);
//console.log($location);
//console.log($location.search().theme);

$window.onload = function(){
console.log('=========' );
if(typeof theme === 'undefined'){
console.log('===1=====' );
  $("link[href*='enhanced_responsive']").prop('disabled', true);
  $("link[href*='basic.css']").prop('disabled', false);
  $("link[href*='enhanced_responsive.css']").prop('disabled', false);
}
else{
console.log('===2=====' );
  $("link[href*='basic.css']").prop('disabled', true);
  $("link[href*='enhanced_responsive.css']").prop('disabled', true);
$(`link[href*='enhanced_responsive_${theme}.css']`).prop('disabled', false);

}
};
    $scope.js = true;

    $('.mortgagecalc').addClass('js');

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
      Repayments.propertyPrice = $scope.affordability.borrowing();
    };

    $scope.calculateLifestyleSpend = function() {
      $scope.affordability.lifestyleSpend = $scope.affordability.calculateLifestyleSpend();
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
      $scope.tabSelector();

      window.focusElementForScreenReaders($('#panel__monthly_repayments').first());
    };

    $scope.showInterest = function($event) {
      $event.preventDefault();
      $scope.viewMonthlyRepayments = false;
      $scope.viewInterestRepayments = true;
      $scope.tabSelector();

      window.focusElementForScreenReaders($('#panel__interest_repayments').first());
    };

    // Helpers
    $scope.preventFormSubmission = function($event) {
      $event.preventDefault();
    };

    $scope.expandedStampDutyInformation = false;
    $scope.toggleStampDutyExpanded = function($event) {
      $event.preventDefault();
      $scope.expandedStampDutyInformation = !$scope.expandedStampDutyInformation;
    };

    $scope.expandedRepaymentMortgageInformation = false;
    $scope.toggleRepaymentExpanded = function($event) {
      $event.preventDefault();
      $scope.expandedRepaymentMortgageInformation = !$scope.expandedRepaymentMortgageInformation;
    };

    $scope.expandedInterestMortgageInformation = false;
    $scope.toggleInterestExpanded = function($event) {
      $event.preventDefault();
      $scope.expandedInterestMortgageInformation = !$scope.expandedInterestMortgageInformation;
    };

    $scope.expandedIntroText = false;
    $scope.toggleIntroExpanded = function($event) {
      $event.preventDefault();
      $scope.expandedIntroText = !$scope.expandedIntroText;
      $('.expander__link--intro').hide();
    }

    $scope.navigateAndFocus = function($event, direction) {
      $event.preventDefault();
      WizardHandler.wizard()[direction || 'next']();

      // We have no hooks for when angular-wizard has completed its navigation, so we have to wait for a tick
      setTimeout(function() {
        iframeHelpers.resizeIframe();
        $('input[name="stamp_duty[price]"]:visible').focus().select();
        $('input[name="affordability[interest_rate]"]:visible').focus();
        $('input[name="affordability[people_attributes][0][annual_income]"]:visible').focus();
      });
      $scope.scrollToTop();
    };

    // Scroll to the top of the page, on navigation
    $scope.scrollToTop = function($event) {
      $("html, body").animate({
        scrollTop: 0
      }, 100);
    };

    // Apply the docker on page navigation
    $scope.showDocker = function(){
      $scope.dockerReady = true;
    };

    // Docker
    $scope.dockerControl = {};
    $scope.dockerReady = false;
    $scope.docked = false;

    // Apply selected attributes to repayment tabs
    $scope.tabSelector = function($event) {
      if($scope.viewMonthlyRepayments) {
        $('.payment_tab').attr('aria-selected', 'false').removeAttr('selected');
        $('.payment_tab:first-child').attr({
          'aria-selected' : 'true',
          'selected' : 'selected'
        });
      } else {
        $('.payment_tab').attr({
          'aria-selected' : 'true',
          'selected' : 'selected'
        });
        $('.payment_tab:first-child').attr('aria-selected', 'false').removeAttr('selected');
      };
    };

    iframeHelpers.resizeIframe();
  }]);

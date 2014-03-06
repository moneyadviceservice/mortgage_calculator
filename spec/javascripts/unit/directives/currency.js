'use strict';

describe("Directives: Currency", function() {

  var element;
  var $scope;
  var form;

  beforeEach(module('mortgageCalculatorApp'));

  beforeEach(inject(function($compile, $rootScope){
    $scope = $rootScope;
    element = angular.element(
      '<form name="form">' +
        '<input type="text" name="annualIncome" ng-model="annualIncome" currency>' +
      '</form>'
    );
    $scope.model = { annualIncome: null};
    $compile(element)($scope);
    $scope.$digest();
    form = $scope.form;
  }));

  it('should be valid initially', function() {
      expect(form.annualIncome.$valid).toBe(true);
  });

  it('should be invalid when user enters letters', function(){
    form.annualIncome.$setViewValue('sas');
    expect(form.annualIncome.$valid).toBe(false);
  });

  it('should contain invalidCurrency when user enters letters', function(){
    form.annualIncome.$setViewValue('asas');
    expect(form.$error.invalidCurrency).toBeDefined();
  });

  it('should not contain invalidCurrency when a user enters a property price without commas', function(){
    form.annualIncome.$setViewValue('50000');
    expect(form.$error.invalidCurrency).not.toBeDefined();
  });

  it('should not contain invalidCurrency when a user enters a property price with commas', function(){
    form.annualIncome.$setViewValue('50,000');
    expect(form.$error.invalidCurrency).not.toBeDefined();
  });

});



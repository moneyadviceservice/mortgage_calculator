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
        '<input type="text" name="annualIncome" ng-model="model.annualIncome" currency data-a-sign="£">' +
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

  xit('element should be initially empty', function() {
    expect(element.find('input').val()).toBe('');
  });

  it('sets the view value to the correct format', function() {
    form.annualIncome.$setViewValue('£30,000.00');
    expect(form.annualIncome.$viewValue).toBe('£30,000.00');
  });

  it('converts input values to integer types', function() {
    form.annualIncome.$setViewValue('£30,000.00');
    expect($scope.model.annualIncome).toEqual(30000);
    expect(form.annualIncome.$valid).toBe(true);
  });

});



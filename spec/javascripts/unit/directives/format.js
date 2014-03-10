'use strict';

describe("Directives: Format", function() {

  var element;
  var $scope;
  var form;

  beforeEach(module('mortgageCalculatorApp'));

  beforeEach(inject(function($compile, $rootScope){
    $scope = $rootScope;
    element = angular.element(
      '<form name="form">' +
        '<input type="text" name="annualIncome" ng-model="model.annualIncome" format="number">' +
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

  it('converts input values to integer types', function() {
    form.annualIncome.$setViewValue('3,000');
    expect($scope.model.annualIncome).toEqual(3000);
    expect(form.annualIncome.$valid).toBe(true);
  });

});



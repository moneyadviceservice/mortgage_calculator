'use strict';

describe('Controller: CalculatorCtrl', function () {

  // load the controller's module
  beforeEach(module('mortgageCalculatorApp'));

  var CalculatorCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    CalculatorCtrl = $controller('CalculatorCtrl', {
      $scope: scope
    });
  }));

  it('contains the scope', function () {
    expect(CalculatorCtrl.scope).not.toBe(null);
  });

  it('attaches the Affordability service', function () {
    expect(scope.affordability).toBeDefined();
  });

  it('sets the selected number of people to 1', function () {
    expect(scope.affordability.selectedOption).toBe(1);
  });

  it('should attach the StampDuty service', function () {
    expect(scope.stampDuty).toBeDefined();
  });

  it('should attach the Repayment service', function () {
    expect(scope.repayments).toBeDefined();
  });



});

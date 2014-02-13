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

  it('should contain the scope', function () {
    expect(CalculatorCtrl.scope).not.toBe(null);
  });

});

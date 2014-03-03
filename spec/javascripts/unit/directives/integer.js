'use strict';

describe('Directives: Integer', function() {
    var element;
    var $scope;
    var form;
    beforeEach(module('mortgageCalculatorApp'));
    beforeEach(inject(function($compile, $rootScope) {
        $scope = $rootScope;
        element = angular.element(
          '<form name="form">' +
            '<input ng-model="model.somenum" name="somenum" integer />' +
          '</form>'
        );
        $scope.model = { somenum: null };
        $compile(element)($rootScope);
        $scope.$digest();
        form = $scope.form;
    }));

    it('converts string inputs to integers', function() {
      form.somenum.$setViewValue('3');
      expect($scope.model.somenum).toEqual(3);
      expect(form.somenum.$valid).toBe(true);
    });
});

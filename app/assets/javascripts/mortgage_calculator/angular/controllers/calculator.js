'use strict';

angular.module('mortgageCalculatorApp')

  .controller('CalculatorCtrl', ['$scope', 'Affordability', function ($scope, Affordability) {

    $scope.affordability = Affordability;

  }]);

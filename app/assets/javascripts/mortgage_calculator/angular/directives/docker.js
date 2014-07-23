'use strict';

App.directive('ngDocker', function() {
  return {
    restrict: 'A',
    scope: {
      docked: '=ngDocked'
    },
    link: function($scope, $element, $attrs, $parse) {
      $element.waypoint('sticky', {
        stuckClass: 'l-stuck',
        handler: function(direction) {
          $scope.docked = !!(direction == 'down');
          $scope.$apply();
        }
      });
    }
  };
});

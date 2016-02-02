'use strict';

App.directive('ngDocker', function() {

  return {
    restrict: 'A',
    scope: {
      docked: '=ngDocked',
      dockerReady: '@',
      control: '='
    },
    link: function($scope, $element, $attrs, $parse) {

      $scope.dockerControl = $scope.control;

      // Do not apply docker if browser width is >= to value of 'ng-docker-hide='
      // Used to disable docker for desktop, above a specified breakpoint.

      $scope.dockerControl.showDocker = function() {
        if ($(window).width() >= $attrs.ngDockerHide) {
          return;
        } else {
          applyDocker();
        }
      };

      // Used for apps where all content/sections are loaded on a single page
      // Don't apply docker if the attribute of docker-ready is false.
      // Also for dockers with no exclusive circumstances (eg. hide for desktop)

      if ($attrs.dockerReady === 'false') {
        return;
      } else {
        applyDocker();
      };

      // Apply docker function

      function applyDocker (){
        $element.waypoint('sticky', {
          stuckClass: 'l-stuck',
          handler: function(direction) {
            $scope.docked = !!(direction == 'down');
            setTimeout(function() {
              $scope.$apply();
            });
            return;
          }
        });
      };

    }
  };
});

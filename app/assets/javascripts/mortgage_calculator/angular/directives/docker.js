'use strict';

App.directive('ngDocker', function() {
  return {
    restrict: 'A',
    controller: [
      '$scope', '$element', '$attrs', '$parse', function($scope, $element, $attrs, $parse) {
        $element.waypoint('sticky', {
          stuckClass: 'sticky--stuck'
        });
      }
    ]
  };
});

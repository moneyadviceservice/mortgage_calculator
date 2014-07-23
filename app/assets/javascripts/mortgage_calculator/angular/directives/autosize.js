'use strict';

App.directive('ngAutosize', function() {
  return {
    restrict: 'A',
    require: '?ngModel',
    scope: {
      value: '=ngModel',
    },
    controller: [
      '$scope', '$element', '$attrs', '$parse', function($scope, $element, $attrs, $parse) {
        var $mirror = $('<span/>').css({
            visibility: 'hidden',
            'white-space': 'pre',
            'font-size': $element.css('font-size')
          }).appendTo('body');

        function updateWidth() {
          var initialWidth = $mirror.innerWidth(),
              paddedWidth = initialWidth + ($element.val().length * 4);

          $element.width(paddedWidth);
        }

        $scope.$watch('value', function (newVal, oldVal) {
          $mirror.html($element.val());
          updateWidth();
        });
      }
    ]
  };
});

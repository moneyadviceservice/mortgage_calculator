'use strict';

App.directive('ngAutosize', function() {
  return {
    restrict: 'A',
    require: '?ngModel',
    scope: {
      value: '=ngModel',
      docked: '=ngDocked'
    },
    controller: [
      '$scope', '$element', '$attrs', '$parse', function($scope, $element, $attrs, $parse) {
        var $mirror = $('<span/>').
            css(getStyleObject()).
            css({
              visibility: 'hidden',
              'white-space': 'pre',
              width: 'auto'
            }).
            appendTo('body');

        function getStyleObject() {
          var styleObject = {},
              propsCaredAbout = ['padding-top', 'padding-left', 'padding-right', 'padding-bottom',
                                  'margin-top', 'margin-left', 'margin-right', 'margin-bottom',
                                  'border-top', 'border-left', 'border-right', 'border-bottom',
                                  'font-size', 'font-family', 'font-weight', 'font-style'];

          $.each(propsCaredAbout, function(i, prop) {
            styleObject[prop] = $element.css(prop);
          });

          return styleObject;
        }

        function updateWidth() {
          $mirror.css({
            'font-size': $element.css('font-size')
          }).html($element.val());
          $element.width($mirror.width()).val($element.val());
        }

        $scope.$watch('docked', function() {
          updateWidth();
        });

        $scope.$watch('value', function() {
          updateWidth();
        });

        // Autonumeric race condition woes
        setTimeout(function() {
          updateWidth();
        }, 100);
      }
    ]
  };
});

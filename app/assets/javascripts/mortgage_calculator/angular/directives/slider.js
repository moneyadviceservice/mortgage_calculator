

App.directive('uiSlider', ['ui.config', function (uiConfig) {
  'use strict';
  uiConfig.uiSlider = uiConfig.uiSlider || {};
  return {
    restrict: 'A',
    require: 'ngModel',
    scope: {
        value: '=ngModel',
        min: '=min',
        max: '=max',
        step: '=step'
    },
    link: function (scope, elm) {
        var expression = {};
        // Set attribute from element
        if (!angular.isUndefined(scope.min)) {
                expression['min'] = parseFloat(scope.min);
        }
        if (!angular.isUndefined(scope.max)) {
                expression['max'] = parseFloat(scope.max);
        }
        if (!angular.isUndefined(scope.step)) {
                expression['step'] = parseFloat(scope.step);
        }

        var options = {
            range: 'min',
            value: scope.value,
            min: 1,
            max: 100,
            slide: function (event, ui) {
                scope.$apply(function () {
                    scope.value = ui.value;
                });
            }
        };



        scope.$watch('value', function (newVal, oldVal) {
            if (!angular.isUndefined(newVal) && newVal != oldVal) {
                elm.slider('value', newVal)
            }
        });

        scope.$watch('min', function (newVal, oldVal) {
            if (!angular.isUndefined(newVal) && newVal != oldVal) {
                elm.slider('option', 'min', newVal)
            }
        });
        scope.$watch('max', function (newVal, oldVal) {
            if (!angular.isUndefined(newVal) && newVal != oldVal) {
                elm.slider('option', 'max', newVal)
            }
        });
        scope.$watch('step', function (newVal, oldVal) {
            if (!angular.isUndefined(newVal) && newVal != oldVal) {
                elm.slider('option', 'step', newVal)
            }
        });


        angular.extend(options, uiConfig.uiSlider, expression);
        elm.slider(options);
    }
  };
}]);

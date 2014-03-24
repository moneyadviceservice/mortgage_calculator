
App.directive('uiSlider', function() {

  var linker = function(scope, element, attrs, ctrl) {

    //Dynamically grab input id passed in from view
    var input = angular.element("input#" + attrs.el),
    expression = {},
    value;

    //Set initial slider state
    var options = {
      range: 'min',
      value: scope.value,
      slide: function (event, ui) {
          scope.$apply(function () {
              scope.value = ui.value;
          });
      }
    };

    //Reconfigre slider when input blurs
    input.on('blur', function() {
      value = parseInt($(this).val().replace(/[^\d|\-+|\.+]/g, ''));
      element.slider({
        min: value / 2,
        max: value * 2,
        value: value,
        step: value <= 100000 ? 5000 : 10000
      });
    })

    // Set attribute from element when they are available
    if (!angular.isUndefined(scope.min)) {
            expression['min'] = parseFloat(scope.min);
    }
    if (!angular.isUndefined(scope.max)) {
            expression['max'] = parseFloat(scope.max);
    }
    if (!angular.isUndefined(scope.step)) {
            expression['step'] = parseFloat(scope.step);
    }

    //Binding magic
    scope.$watch('value', function (newVal, oldVal) {
        if (!angular.isUndefined(newVal) && newVal != oldVal) {
            element.slider('value', newVal)
        }
    });

    scope.$watch('min', function (newVal, oldVal) {
        if (!angular.isUndefined(newVal) && newVal != oldVal) {
            element.slider('option', 'min', newVal)
        }
    });
    scope.$watch('max', function (newVal, oldVal) {
        if (!angular.isUndefined(newVal) && newVal != oldVal) {
            element.slider('option', 'max', newVal)
        }
    });
    scope.$watch('step', function (newVal, oldVal) {
        if (!angular.isUndefined(newVal) && newVal != oldVal) {
            element.slider('option', 'step', newVal)
        }
    });

    //Initial declaration of slider
    angular.extend(options, expression);
    element.slider(options);
  };

  var controller = function($scope) {};

  return {
    restrict: 'A',
    require: 'ngModel',
    controller: controller,
    link: linker,
    scope: {
      value: '=ngModel',
      min: '=min',
      max: '=max',
      step: '=step'
    }
  };
});

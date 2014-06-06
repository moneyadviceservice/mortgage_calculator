'use strict';

App.directive('uiSlider', function() {

  var linker = function(scope, element, attrs, ctrl) {

    //Dynamically grab input id passed in from view
    var input = angular.element('input.' + attrs.dynamicFor),
        expression = {},
        value,
        percentageForMin = attrs.percentageForMinimum || 50,
        percentageForMax = attrs.percentageForMaximum || 200,
        labelFollower = attrs.labelFollower || '',
        $labelFollower = $(labelFollower).appendTo(element);

    //Fire GA Events
    var gaRefinement = function(){
      window._gaq = window._gaq || [];

      var category = attrs.analyticsCategory,
          action = attrs.analyticsAction,
          label = attrs.analyticsLabel,
          refined = element.attr('refined');

      if (action == 'Refinement') {
        if (!(typeof refined !== 'undefined' && refined !== false)) {
          window._gaq.push(['_trackEvent',category,action,label]);
          element.attr('refined', '');
        }
      }
    };

    //Set initial slider state
    var options = {
      range: 'min',
      min: (percentageForMin / 100) * scope.value,
      max: (percentageForMax / 100) * scope.value,
      value: scope.value,
      slide: function (event, ui) {
        scope.$apply(function () {
            if (ui && ui.value) scope.value = ui.value;
            gaRefinement();
            moveFollower();
        });
      }
    };

    var moveFollower = function() {
      if ($labelFollower) {
        var labelWidth = $labelFollower.width();
        var sliderWidth = element.width();
        var handleLeft = parseFloat(element.find('.ui-slider-handle').css('left'));

        if (handleLeft < (labelWidth / 2)) {
          handleLeft = (labelWidth / 2);
        }

        if (handleLeft + (labelWidth / 2) > sliderWidth) {
          handleLeft = sliderWidth - (labelWidth / 2);
        }

        $labelFollower.css({
          left: handleLeft,
          marginLeft: '-' + (labelWidth / 2) + 'px'
        });
      }
    };

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
        element.slider('value', newVal);
        moveFollower();
      }
    });

    scope.$watch('min', function (newVal, oldVal) {
      if (!angular.isUndefined(newVal) && newVal != oldVal) {
        element.slider('option', 'min', newVal);
        moveFollower();
      }
    });
    scope.$watch('max', function (newVal, oldVal) {
      if (!angular.isUndefined(newVal) && newVal != oldVal) {
        element.slider('option', 'max', newVal);
        moveFollower();
      }
    });
    scope.$watch('step', function (newVal, oldVal) {
      if (!angular.isUndefined(newVal) && newVal != oldVal) {
        element.slider('option', 'step', newVal);
        moveFollower();
      }
    });

    //Initial declaration of slider
    angular.extend(options, expression);
    element.slider(options).on('slide', options.slide);

    //Reconfigre slider when input blurs
    input.on('blur keyup', function() {
      value = parseInt($(this).val().replace(/[^\d|\-+|\.+]/g, '')) || 0;
      element.slider({
        min: (percentageForMin / 100) * value,
        max: (percentageForMax / 100) * value,
        value: value,
        step: (value / 100) * 1
      });
    });

    setTimeout(function() {
      element.trigger('slide');
    });
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

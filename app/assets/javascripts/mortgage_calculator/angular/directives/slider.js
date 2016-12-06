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
        $labelFollower = $(labelFollower).appendTo(element),
        sliderDefaultMax = attrs.customSliderMax || 250;

    //Fire GA Events
    var gaRefinement = function(){
      window.dataLayer = window.dataLayer || [];

      var category = attrs.analyticsCategory,
          action = attrs.analyticsAction,
          label = attrs.analyticsLabel,
          refined = element.attr('refined');

      if (action == 'Refinement') {
        if (!(typeof refined !== 'undefined' && refined !== false)) {
          dataLayer.push({
            'event': 'GAEvent',
            'eventCategory': category,
            'eventAction'  : action,
            'eventLabel'   : label
          });

          element.attr('refined', '');
        }
      }
    };

    //Set initial slider state
    var options = {
      range: 'min',
      min: (percentageForMin / 100) * scope.value,
      max: (percentageForMax / 100) * (scope.value || sliderDefaultMax),
      value: scope.value,
      slide: function (event, ui) {
        scope.$apply(function () {
          if (ui && ui.value) {
            scope.value = ui.value;
            gaRefinement();
          }

          moveFollower();
        });
      }
    };

    var moveFollower = function() {
      if ($labelFollower) {
        var labelWidth = $labelFollower.width(),
            sliderWidth = element.width(),
            handleOffset = 6,
            handleLeft = parseFloat(element.find('.ui-slider-handle').css('left'));

        if (handleLeft < (labelWidth / 2)) {
          handleLeft = (labelWidth / 2);
        }

        if (handleLeft + (labelWidth / 2) > sliderWidth) {
          handleLeft = sliderWidth - (labelWidth / 2);
        }

        $labelFollower.css({
          left: handleLeft - handleOffset + 'px',
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

    scope.$watch('docked', function() {
      moveFollower();
    });

    //Initial declaration of slider
    angular.extend(options, expression);
    element.slider(options).on('slide', options.slide);

    angular.element('.stamp-duty__submit').on('click', function() {
      reconfigureSlider();
    });

    input.on('blur keyup', function() {
      reconfigureSlider();
    });

    function reconfigureSlider() {
      value = parseInt($(input).val().replace(/[^\d|\-+|\.+]/g, '')) || 0;
      element.slider({
        min: (percentageForMin / 100) * value,
        max: ((percentageForMax / 100) * value) || sliderDefaultMax,
        value: value,
        step: (value / 100) * 1
      });
    }

    setTimeout(function() {
      element.trigger('slide');
    });
  };

  return {
    restrict: 'A',
    require: 'ngModel',
    link: linker,
    scope: {
      value: '=ngModel',
      min: '=min',
      max: '=max',
      step: '=step',
      docked: '=ngDocked'
    }
  };
});

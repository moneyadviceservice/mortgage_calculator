'use strict';

App.directive('ngTooltip', function() {
  return {
    restrict: 'A',
    controller: [
      '$scope', '$element', '$attrs', '$parse', function($scope, $element, $attrs, $parse) {
        var tooltipID = $element.attr('id'),
            $inputTarget = $('[aria-describedby="' + tooltipID + '"]'),
            hiddenClass = 'is-hidden',
            persistOnScreen = $element.attr('data-tooltip-persist'),
            debounceTimer;

        $element.addClass(hiddenClass);

        $inputTarget.
          on('focusin', function() {
            $element.removeClass(hiddenClass);
          }).
          on('focusout', handleBlur);

        if ($inputTarget.is(':focus')) {
          $element.removeClass(hiddenClass);
        }

        $element.on('focusout', handleBlur);

        function handleBlur(e) {
          if (persistOnScreen) {
            // If we do not want the tooltip to hide onBlur
            return true;
          }

          clearTimeout(debounceTimer);
          debounceTimer = setTimeout(function() {
            var $activeElement = $(document.activeElement),
                $activeParents = $activeElement.parents();

            if (!($activeElement.is($element) || $activeElement.is($inputTarget) ||
              $activeParents.filter($element).length || $activeParents.filter($inputTarget).length)) {
              $element.addClass(hiddenClass);
            }
          });

        }
      }
    ]
  };
});

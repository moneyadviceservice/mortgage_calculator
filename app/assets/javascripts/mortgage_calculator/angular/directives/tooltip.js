'use strict';

App.directive('ngTooltip', function() {
  return {
    restrict: 'A',
    controller: [
      '$scope', '$element', '$attrs', '$parse', function($scope, $element, $attrs, $parse) {
        var tooltipID = $element.attr('id'),
            $inputTarget = $('[aria-describedby="' + tooltipID + '"]'),
            hiddenClass = 'tooltip--hidden',
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

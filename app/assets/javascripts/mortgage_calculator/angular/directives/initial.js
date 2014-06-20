'use strict';

App.directive('ngInitial', function() {
  return {
    restrict: 'A',
    controller: [
      '$scope', '$element', '$attrs', '$parse', function($scope, $element, $attrs, $parse) {
        var getter, setter, val;
        val = $attrs.ngInitial || $attrs.value || '';

        if ($attrs.ngInitialAsString !== "true") {
          val = parseFloat(val.replace(/[^\d|\-+|\.+]/g, ''));
        }

        getter = $parse($attrs.ngModel);
        setter = getter.assign;
        setter($scope, val);
      }
    ]
  };
});

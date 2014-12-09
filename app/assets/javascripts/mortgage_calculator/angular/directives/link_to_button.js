'use strict';

App.directive('linkToButton', function () {
  return {
    replace: true,
    transclude: true,
    template: '<button><div ng-transclude></div></button>'
  }
})

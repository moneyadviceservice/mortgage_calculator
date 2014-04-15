App.directive('affectsHeight', ['iframeHelpers', function(iframeHelpers) {
  var linker = function (scope, element, attrs, ctrl) {
    element.on(attrs['affectsHeight'], function(){
      iframeHelpers.resizeIframe();
    });
  };

  return {
    restrict: 'A',
    link: linker
  };
}]);

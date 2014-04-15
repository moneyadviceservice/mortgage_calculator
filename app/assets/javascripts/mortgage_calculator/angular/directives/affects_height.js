var affectsHeight = affectsHeight || {};

affectsHeight.helpers = {
  resizeIframe: function() {
    setTimeout(function() {
      var minPageHeight = 250; // px
      var height = document.documentElement.offsetHeight;
      height = Math.max(height, minPageHeight);
      window.parent.postMessage('MASRESIZE-' + height, '*');
    });
  }
};

App.directive('affectsHeight', function () {
  var linker = function (scope, element, attrs, ctrl) {
    element.on(attrs['affectsHeight'], function(){
      if (window.postMessage) {
        affectsHeight.helpers.resizeIframe();
      }
    });
  };

  return {
    restrict: 'A',
    link: linker
  };
});

App.directive('affectsHeight', function () {
  var linker = function (scope, element, attrs, ctrl) {
    element.on('click', function(){
      var minPageHeight = 250; // px
      if (window.postMessage) {
        var height = document.documentElement.offsetHeight;
        height = Math.max(height, minPageHeight);
        window.parent.postMessage('MASRESIZE-' + height, '*');
      }
    });
  };

  return {
    restrict: 'A',
    link: linker
  };
});

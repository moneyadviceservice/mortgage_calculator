App.directive('analyticsCompletion', function () {
  var linker = function (scope, element, attrs, ctrl) {
    element.on('click', function(){
      _gaq.push(['_trackEvent','Mortgage Calculator','Completion','Click']);
    });
  };

  return {
    restrict: 'A',
    link: linker
  };
});

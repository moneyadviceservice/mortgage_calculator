App.directive('analyticsRefinement', function () {
  var linker = function (scope, element, attrs, ctrl) {
    element.on('change', function(){
      _gaq.push(['_trackEvent','Mortgage Calculator','Refinement','Click']);
    });
  };

  return {
    restrict: 'A',
    link: linker
  };
});

App.directive('analytics', function () {
  var linker = function (scope, element, attrs, ctrl) {
    element.on('click', function(){
      category = attrs['analyticsCategory'];
      action = attrs['analyticsAction'];
      label = attrs['analyticsLabel'];

      _gaq.push(['_trackEvent',category,action,label]);
    });
  };

  return {
    restrict: 'A',
    link: linker
  };
});

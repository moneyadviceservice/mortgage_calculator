App.directive('analytics', function () {
  var linker = function (scope, element, attrs, ctrl) {
    element.on('click', function(){
      type = attrs['analyticsOn'];
      category = attrs['analyticsCategory'];
      action = attrs['analyticsAction'];
      label = attrs['analyticsLabel'];

      if (type == 'click'){
        _gaq.push(['_trackEvent',category,action,label]);
      }
    });

    element.on('change', function(){
      type = attrs['analyticsOn'];
      category = attrs['analyticsCategory'];
      action = attrs['analyticsAction'];
      label = attrs['analyticsLabel'];

      if (type == 'change'){
        _gaq.push(['_trackEvent',category,action,label]);
      }
    });
  };

  return {
    restrict: 'A',
    link: linker
  };
});

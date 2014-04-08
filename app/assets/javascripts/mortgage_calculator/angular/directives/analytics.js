App.directive('analytics', function () {
  var linker = function (scope, element, attrs, ctrl) {
    var type = attrs['analyticsOn'],
        category = attrs['analyticsCategory'],
        action = attrs['analyticsAction'],
        label = attrs['analyticsLabel'];

    element.on('click', function(){
      if (type == 'click'){
        _gaq.push(['_trackEvent',category,action,label]);
      }
    });

    element.on('change', function(){
      if (type == 'change'){
        if (action == 'Refinement') {
          var refined = element.attr('refined');
          if (!(typeof refined !== 'undefined' && refined !== false)) {
            _gaq.push(['_trackEvent',category,action,label]);
            element.attr('refined', '');
          }
        } else {
          _gaq.push(['_trackEvent',category,action,label]);
        }
      }
    });
  };

  return {
    restrict: 'A',
    link: linker
  };
});

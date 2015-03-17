'use strict';

App.directive('analytics', function () {
  var linker = function (scope, element, attrs, ctrl) {
    var type = attrs.analyticsOn,
        category = attrs.analyticsCategory,
        action = attrs.analyticsAction,
        label = attrs.analyticsLabel,
        toolName = attrs.analyticsToolName;

    element.on('click', function(){
      if (type == 'click'){
        dataLayer.push({
          'event': 'GAEvent',
          'eventCategory': category,
          'eventAction'  : action,
          'eventLabel'   : label,
          'tool_name'    : toolName
        });
      }
    });

    element.on('change', function(){
      if (type == 'change'){
        if (action == 'Refinement') {
          var refined = element.attr('refined');
          if (!(typeof refined !== 'undefined' && refined !== false)) {
            dataLayer.push({
              'event': 'GAEvent',
              'eventCategory': category,
              'eventAction'  : action,
              'eventLabel'   : label,
              'tool_name'    : toolName
            });

            element.attr('refined', '');
          }
        } else {
          dataLayer.push({
            'event': 'GAEvent',
            'eventCategory': category,
            'eventAction'  : action,
            'eventLabel'   : label,
            'tool_name'    : toolName
          });

        }
      }
    });
  };

  return {
    restrict: 'A',
    link: linker
  };
});

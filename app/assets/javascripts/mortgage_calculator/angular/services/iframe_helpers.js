'use strict';

App.factory('iframeHelpers', function() {
  var iframeHelpers = {
    resizeIframe: function() {
      setTimeout(function() {
        if (window.postMessage) {
          var minPageHeight = 250; // px
          var height = document.documentElement.offsetHeight;
          height = Math.max(height, minPageHeight);
          window.parent.postMessage('MASRESIZE-' + height, '*');
        }
      });
    }
  };

  return iframeHelpers;
});


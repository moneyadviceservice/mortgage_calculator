'use strict';

App.factory('iframeHelpers', function() {
  var iframeHelpers = {
    resizeIframe: function() {
      setTimeout(function() {
        if (window.postMessage) {
          var minPageHeight = 250,
              docElement = document.documentElement,
              height = Math.max(docElement.scrollHeight, docElement.offsetHeight, docElement.clientHeight);

          window.parent.postMessage('MASRESIZE-' + height, '*');
        }
      });
    }
  };

  return iframeHelpers;
});


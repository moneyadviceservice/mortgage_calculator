// Focusing elements for screen readers takes a little mucking about.
window.focusElementForScreenReaders = function(element) {
  setTimeout(function() {
    element.attr('tabindex', '-1'); // This makes the element focusable
    element.focus();

    setTimeout(function() {
      // This prevents the element from appearing in the wrong place in the
      // tabindex.
      element.removeAttr('tabindex');
    }, 4);
  }, 500);
};

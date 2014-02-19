  var AffordabilityPage = function() {
    this.title = element(by.css('h1'));

    this.get = function() {
      browser.get('mortgage_calculator/affordability');
    };
  };

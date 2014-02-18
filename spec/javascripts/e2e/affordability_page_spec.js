describe('E2E: affordability calculator page', function() {

  var ptor;

  beforeEach(function() {
    browser.get('#/affordability');
    ptor = protractor.getInstance();
  });



  it('should load the affordability calculator page', function() {

    var ele = by.css('h2');
    expect(ptor.isElementPresent(ele)).toBe(true);

  });



});

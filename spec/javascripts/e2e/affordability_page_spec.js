

describe('E2E: affordability calculator page', function() {


 var affordabilityPage = new AffordabilityPage();


  beforeEach(function() {
    affordabilityPage.get();
  });

  it('should load the affordability calculator page', function() {
    expect(affordabilityPage.title.getText()).toBe('Find out how much you can borrow');
  });


});



'use strict';

describe("Filters: Years", function() {

  beforeEach(module('mortgageCalculatorApp'));

  var yearsFilter;
  beforeEach(inject(function ($filter) {
    yearsFilter = $filter('years');
  }));

  it('exists in the mortgage calculator', function() {
    expect(yearsFilter).not.toBeNull();
  });

  it('applies a years suffix', function() {
    expect(yearsFilter('4')).toBe('4 years');
  });

});


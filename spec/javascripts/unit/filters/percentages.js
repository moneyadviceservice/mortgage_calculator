

'use strict';

describe("Filters: Percentages", function() {

  beforeEach(module('mortgageCalculatorApp'));

  var percentagesFilter;
  beforeEach(inject(function ($filter) {
    percentagesFilter = $filter('percentages');
  }));

  it('exists in the mortgage calculator', function() {
    expect(percentagesFilter).not.toBeNull();
  });

  it('applies a percentage suffix', function() {
    expect(percentagesFilter('4.5')).toBe('4.5%');
  });

});



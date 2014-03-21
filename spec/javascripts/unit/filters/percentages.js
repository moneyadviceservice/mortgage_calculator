

'use strict';

describe("Filters: Percentages", function() {

  beforeEach(module('mortgageCalculatorApp'));

  it('exists in the mortgage calculator', inject(function($filter) {
    expect($filter('percentages')).not.toBeNull();
  }));

  it('applies a percentage suffix', inject(function($filter) {
    expect($filter('percentages')('4.5')).toBe('4.5%');
  }));

});



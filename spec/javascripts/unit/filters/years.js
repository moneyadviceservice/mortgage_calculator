
'use strict';

describe("Filters: Years", function() {

  beforeEach(module('mortgageCalculatorApp'));


  it('exists in the mortgage calculator', inject(function($filter) {
    expect($filter('years')).not.toBeNull();
  }));

  it('applies a years suffix', inject(function($filter) {
    expect($filter('years')('4')).toBe('4 years');
  }));

});



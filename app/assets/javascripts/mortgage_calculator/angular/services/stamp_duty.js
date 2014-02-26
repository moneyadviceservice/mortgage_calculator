'use strict';

angular.module('mortgageCalculatorApp')
  .factory('StampDuty', function() {

    var stampDuty = {
      propertyPrice : 0,
      rates         : {
        '2000000' : 0.07,
        '1000000' : 0.05,
        '500000'  : 0.04,
        '250000'  : 0.03,
        '125000'  : 0.01,
        '0'       : 0
      },


      rate : function() {
        var applied_rate;
        _.each(this.rates, function(value, key) {
          var incomeThreshold = parseInt(key);
          if (this.propertyPrice >= incomeThreshold) {
            applied_rate = value;
          }
        }, this) || 0;
        return applied_rate;
      },

      percentRate : function() {
        return Math.round(this.rate() * 100);
      },

      cost : function() {
        return this.rate() * this.propertyPrice;
      },

      totalPurchase : function() {
        return (parseInt(this.propertyPrice) + parseInt(this.cost()));
      }

    };

    return stampDuty;
  });




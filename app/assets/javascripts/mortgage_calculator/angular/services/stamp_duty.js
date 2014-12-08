'use strict';

App.factory('StampDuty', function() {
    var stampDuty = {
      propertyPrice : 0,
      rates: [
        {
          threshold: 125000,
          rate: 0
        }, {
          threshold: 250000,
          rate: 2
        }, {
          threshold: 925000,
          rate: 5
        }, {
          threshold: 1500000,
          rate: 10
        }, {
          threshold: 100000000,
          rate: 12
        }
      ],

      cost: function() {
        var totalTax = 0,
            remaining = this.propertyPrice;

        for (var i = 0; i < this.rates.length; i++) {
          var rateObj = this.rates[i],
              previousRateObj = i > 0 ? this.rates[i - 1] : null,
              bandwidth = 0,
              remainingTaxable = 0,
              bandTaxable = 0;

          if (!previousRateObj) {
            bandwidth = rateObj.threshold;
          } else {
            bandwidth = rateObj.threshold - previousRateObj.threshold;
          }

          remainingTaxable = Math.min(rateObj.threshold, remaining);
          bandTaxable = Math.min(bandwidth, remainingTaxable);
          totalTax += (bandTaxable * rateObj.rate / 100);
          remaining -= bandwidth;

          if (remaining < 0) {
            break;
          }
        }

        return totalTax;
      },

      totalPurchase : function() {
        return (this.propertyPrice + this.cost());
      }
    };

    return stampDuty;
  });


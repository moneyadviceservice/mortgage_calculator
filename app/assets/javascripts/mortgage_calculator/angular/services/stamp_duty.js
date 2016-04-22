'use strict';

App.factory('StampDuty', function() {
    var SECOND_HOME_TAX_THRESHOLD = 40000
      , SECOND_HOME_TAX_RATE = 3;

    var stampDuty = {
      propertyPrice : 0,
      isSecondHome: false,
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

        if (this.isSecondHome && this.propertyPrice >= SECOND_HOME_TAX_THRESHOLD) {
          totalTax += this.propertyPrice * (SECOND_HOME_TAX_RATE / 100);
        }

        return totalTax;
      },

      totalPurchase : function() {
        return (this.propertyPrice + this.cost());
      },

      percentageTax : function() {
        return ((this.cost() / this.propertyPrice) * 100) || 0;
      }
    };

    return stampDuty;
  });


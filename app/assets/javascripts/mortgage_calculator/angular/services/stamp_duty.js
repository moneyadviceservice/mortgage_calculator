'use strict';

angular.module('mortgageCalculatorApp')
  .factory('StampDuty', function() {

    var stampDuty = {
      propertyPrice : 0,
      rates         : [
        {'2000000' : 0.07},
        {'1000000' : 0.05},
        {'500000'  : 0.04},
        {'250000'  : 0.03},
        {'125000'  : 0.01},
        {'0'       : 0}
      ],


      rate : function() {
        var value = _.find(this.rates, function(el) {
          var thresh = Number(_.keys(el));
          return this.propertyPrice >= thresh;
        }, this);

        var appliedRate = Number(_.values(value));
        return appliedRate;

      },

      percentRate : function() {
        return Math.round(this.rate() * 100);
      },

      cost : function() {
        return this.rate() * this.propertyPrice;
      },

      totalPurchase : function() {
        return (this.propertyPrice + this.cost());
      }

    };

    return stampDuty;
  });




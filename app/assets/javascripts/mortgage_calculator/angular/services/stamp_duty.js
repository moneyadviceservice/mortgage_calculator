'use strict';

App.factory('StampDuty', function() {
    var stampDuty = {
      propertyPrice : 0,
      rates         : [
        {'2000001' : 0.07},
        {'1000001' : 0.05},
        {'500001'  : 0.04},
        {'250001'  : 0.03},
        {'125001'  : 0.01},
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


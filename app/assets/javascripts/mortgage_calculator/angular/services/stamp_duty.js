'use strict';

App.factory('StampDuty', function() {
    var cfg = window.calculator_config || {};
    var stampDuty = {
      propertyPrice : 0,
      buyerType: '',
      completionDate: cfg.completion_date,
      secondHomeTaxThreshold: cfg.second_home_threshold || 0,
      secondHomeTaxRate: cfg.second_home_tax_rate || 0,
      firstTimeBuyerThreshold: cfg.first_time_buyer_threshold || 0,
      rates: {
          higher: cfg.higher || [],
          standard: cfg.standard || [],
          ftb: cfg.ftb || []
      },

      cost: function() {
        var totalTax = 0,
            remaining = this.propertyPrice,
            rates,
            $conditionalMessage = $('.stamp-duty__FTB_conditional'),
            $howcalculatedFTB = $('.stamp-duty__explanation-firsttimebuyer'),
            $howcalculatedNextHome = $('.stamp-duty__explanation-nexthome');

        if (this.buyerType === 'isFTB') {
          $howcalculatedNextHome.removeClass('is-active');
          $howcalculatedFTB.addClass('is-active');

          if (this.propertyPrice <= this.firstTimeBuyerThreshold || cfg.tool == 'lbtt') {
            rates = this.rates.ftb;
            $conditionalMessage.removeClass('is-active');
          } else {
            rates = this.rates.standard;
            $conditionalMessage.addClass('is-active');
          }
        } else if (cfg.tool === 'ltt' && this.buyerType === 'isSecondHome') {
          rates = this.rates.higher;
          $conditionalMessage.removeClass('is-active');
          $howcalculatedFTB.removeClass('is-active');
          $howcalculatedNextHome.addClass('is-active');
        } else {
          rates = this.rates.standard;
          $conditionalMessage.removeClass('is-active');
          $howcalculatedFTB.removeClass('is-active');
          $howcalculatedNextHome.addClass('is-active');
        }

        for (var i = 0; i < rates.length; i++) {
          var rateObj = rates[i],
              previousRateObj = i > 0 ? rates[i - 1] : null,
              bandwidth = 0,
              remainingTaxable = 0,
              bandTaxable = 0;

          if(rateObj.threshold === null) {
              rateObj.threshold = Infinity;
          }

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

        if (cfg.tool === 'ltt') {
          if (this.buyerType === 'isSecondHome' && this.propertyPrice < this.secondHomeTaxThreshold) {
            totalTax = 0;
          }
        } else {
          if (this.buyerType === 'isSecondHome' && this.propertyPrice >= this.secondHomeTaxThreshold) {
            totalTax += this.propertyPrice * (this.secondHomeTaxRate / 100);
          }
        }

        if (cfg.tool === 'ltt') {
          return totalTax;
        } else {
          return Math.floor(totalTax);
        }
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

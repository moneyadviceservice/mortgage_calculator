

App.filter('customCurrency', ["$filter", function($filter) {
  return function(amount, currencySymbol, numberType) {
    var currency = $filter('currency');
    var output = currency(amount, currencySymbol);

    if (amount < 0) {
      output = output.replace("(", "-").replace(")", "");
    }

    if (numberType === 'whole'){
      output = output.split(".")[0];
    }

    return output;
  };
}]);

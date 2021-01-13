module MortgageCalculator
  module ApplicationHelper
    def calculator_name
      {
        'affordabilities' => 'affordability',
        'stamp_duties'    => 'stamp_duty',
        'repayments'      => 'mortgage_calculator',
        'land_transaction_taxes' => 'land_transaction_tax',
        'land_and_buildings_transaction_taxes' => 'land_and_buildings_transaction_tax'
      }[controller_name]
    end

    def full_mortgage_calculator_url
      if I18n.locale == :cy
        "https://www.moneyhelper.org/cy/homes/buying-a-home/mortgage-calculator"
      else
        "https://www.moneyhelper.org/en/homes/buying-a-home/mortgage-calculator"
      end
    end

    def full_stamp_duty_calculator_url
      if I18n.locale == :cy
        "https://www.moneyhelper.org/cy/homes/buying-a-home/stamp-duty-calculator"
      else
        "https://www.moneyhelper.org/en/homes/buying-a-home/stamp-duty-calculator"
      end
    end

    def full_mortgage_affordability_calculator_url
      if I18n.locale == :cy
        "https://www.moneyhelper.org/cy/homes/buying-a-home/mortgage-affordability-calculator"
      else
        "https://www.moneyhelper.org/en/homes/buying-a-home/mortgage-affordability-calculator"
      end
    end

    def no_follow?
      syndicated_tool_request? ? "nofollow" : nil
    end

    def localize_route(route)
      LocalizeRoute.new(route, I18n.locale, controller).call
    end
  end
end

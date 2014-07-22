module MortgageCalculator
   module UiComponentsHelper
     def field_tooltip(*args)
       render 'mortgage_calculator/affordabilities/field_tooltip', *args
     end
   end
end

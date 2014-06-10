module MortgageCalculator
   module UiComponentsHelper
      def inset_block(text)
        render 'mortgage_calculator/affordabilities/inset-block', text: text
      end
   end
end

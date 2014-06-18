module MortgageCalculator
   module UiComponentsHelper
      def inset_block(text)
        render 'mortgage_calculator/affordabilities/inset_block', text
      end

      def field_tooltip(args)
        render 'mortgage_calculator/affordabilities/field_tooltip', args
      end
   end
end

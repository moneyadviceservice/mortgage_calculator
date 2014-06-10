module UI
  module Sections
    class Slider < SitePrism::Section
      def set(value)
        self.value = value
      end

      private

      def value
        root_element['aria-valuenow']
      end

      def value=(value)
        page.execute_script("$('##{root_element['id']}').trigger('slide', { value: #{value} });")
      end
    end
  end
end

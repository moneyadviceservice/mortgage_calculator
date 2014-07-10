module MortgageCalculator
  class LocalizeRoute
    attr_reader :route, :locale, :controller

    def initialize(route, locale, controller)
      @route = route
      @locale = locale
      @controller = controller
    end

    def call
      case locale
      when :cy
        controller.public_send("#{route}".gsub('path', 'cy_path'))
      else
        controller.public_send(route)
      end
    end
  end
end

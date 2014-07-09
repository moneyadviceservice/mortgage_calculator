module MortgageCalculator
  class LocalizeRoute
    include MortgageCalculator::Engine.routes.url_helpers

    attr_reader :route, :locale

    def initialize(route, locale = :en)
      @route = route
      @locale = locale
    end

    def call
      case locale
      when :cy
        public_send("#{route}".gsub('path', 'cy_path'))
      else
        public_send(route)
      end
    end
  end
end

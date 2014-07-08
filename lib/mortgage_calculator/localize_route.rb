module MortgageCalculator
  class LocalizeRoute
    include MortgageCalculator::Engine.routes.url_helpers

    attr_reader :route, :locale

    def initialize(route, locale = :en)
      @route = route
      @locale = locale
    end

    def call
      return public_send(route) if locale == :en
      return public_send("#{route}".gsub('path', 'cy_path')) if locale == :cy
    end
  end
end

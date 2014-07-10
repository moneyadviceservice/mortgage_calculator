module MortgageCalculator
  class LocalizeRoute
    include MortgageCalculator::Engine.routes.url_helpers

    attr_reader :route, :locale, :scope

    def initialize(route, locale = :en, scope)
      @route = route
      @locale = locale
      @scope = scope
    end

    def call
      case locale
      when :cy
        scope.public_send("#{route}".gsub('path', 'cy_path'))
      else
        scope.public_send(route)
      end
    end
  end
end

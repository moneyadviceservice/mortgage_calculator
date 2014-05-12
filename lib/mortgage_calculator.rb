require "mortgage_calculator/engine"
require 'mortgage_calculator/currency_input'

module MortgageCalculator
  DAYS_IN_A_MONTH = 30.4368
  DAYS_IN_A_YEAR = 365.242

  mattr_accessor :affordability_enabled

  def self.configure
    yield self
  end

  class MyFormBuilder < ActionView::Helpers::FormBuilder
    def errors_for(object, field = nil)
      # do delegation split

      if field
        if _error_objects[object][field]
          string ||= ""
          _error_objects[object][field].each do |number,message|
            string << "#{number}. #{field} #{message}<br>"
          end

          @template.content_tag(:p, string.html_safe)
        end
      else
        _error_objects[object] ||= {}

        object.errors.each do |field, error|
          _error_objects[object][field] ||= {}
          _error_objects[object][field][_error_counter] = error
          _increment_error_counter
        end

        string ||= ""
        _error_objects[object].each do |field,errors|
          errors.each do |number,message|
            string << "#{number}. #{field} #{message}<br>"
          end
        end

        @template.content_tag(:p, string.html_safe)
      end
    end

    private

    def _error_objects
      @_error_objects ||= {}
    end

    def _error_counter
      @_error_counter ||= 1
    end

    def _increment_error_counter
      @_error_counter += 1
    end
  end
end

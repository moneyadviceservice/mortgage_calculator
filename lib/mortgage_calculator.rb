require "mortgage_calculator/engine"
require 'mortgage_calculator/currency_input'
require 'mas/frontend/helpers'

module MortgageCalculator
  DAYS_IN_A_MONTH = 30.4368
  DAYS_IN_A_YEAR = 365.242

  mattr_accessor :affordability_enabled

  def self.configure
    yield self
  end

  class MyFormBuilder < ActionView::Helpers::FormBuilder

    def validates(*objects)
      objects.flatten.each do |object|
        all_errors.add(object)
      end
    end

    def validation_summary
      return '' unless all_errors.any?

      errors_content = ''
        errors.each do |object, field, error_message|
          "<li><a href='##{field_errors_id(object, field)}'>#{error_message}</a></li>"
         end

      summary = %Q{
<div class="validation-summary">
  <div class='validation-summary__content-container'>
    <p class="validation-summary__title">
      #{all_errors.count} errors found:
    </p>
    <ol class="validation-summary__list">
      #{error_content}
    </ol>
  </div>
</div>
      }

      raw(summary)
    end

    def errors_for(object, field = nil)
      out = ''

      all_errors.each_for(object, field) do |object, field, message, index|
        out << "<p>#{index + 1}. #{message}</p>"
      end

      raw("<div id='#{field_errors_id(object, field)}'>#{out}</div>") unless out.blank?
    end

  private

    def all_errors
      @all_errors ||= ListOfOrderedErrors.new
    end

    def field_errors_id(object, field)
      # The Tag_ class is at the bottom of this file. It is a hack, but I don't know a better
      # way to get at generated IDs :(
      tag = Tag_.new(ActiveModel::Naming.param_key(object), field, self, object)

      "{tag.generated_id}-errors"
    end

  end
end

# Potentially this could completely replace ordered errors?
class ListOfOrderedErrors
    include Enumerable

    attr_reader :inner_list
    private :inner_list

    def initialize
      @inner_list = {}
    end

    def add(object)
      @all_errors = nil
      inner_list[object] = MAS::Frontend::Helpers::Validation::OrderedErrors.new(object.errors)
    end

    def each(&block)
      all_errors
        .each_with_index
        .map { |entry, index| [entry[:object], entry[:field], entry[:message], index] }
        .each(&block)
    end

    def each_for(object, field = nil, &block)
      select { |entry, index| entry[:object] == object && (field.nil? || entry[:field] == field) }
        .each(&block)
    end

  private

    def all_errors
      @all_errors ||= inner_list.flat_map do |object, errors|
        errors.map do |field, message|
          {
            object: object,
            field: field,
            message: message
          }
        end
      end
    end

  end

# this is a hack to get the FormBuilder generated IDs
# it needs a better name
class Tag_ < ActionView::Helpers::InstanceTag
  def generated_id
    options = {}
    add_default_name_and_id(options)

    options['id']
  end
end

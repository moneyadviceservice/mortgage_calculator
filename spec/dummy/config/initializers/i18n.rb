I18n.enforce_available_locales = true

# raise exceptions when there is an incorrect or missing i18n key
# in development and test
module I18n
  def self.just_raise_that_exception(*args)
    raise "i18n #{args.first}"
  end
end
I18n.exception_handler = :just_raise_that_exception

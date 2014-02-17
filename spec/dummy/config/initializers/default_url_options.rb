default_url_options_lambda = ->{{locale: I18n.locale}}

class << default_url_options_lambda
  def to_hash
    call
  end
end

# this provides default url options to the main_app route across requests running
# in the context of the both the application and all engines.
Rails.application.routes.default_url_options = default_url_options_lambda

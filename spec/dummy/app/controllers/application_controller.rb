class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale]
  end

  def self.default_url_options
    { locale: I18n.locale }
  end

  include MAS::Templating::ControllerConcerns::ParentTemplateSupport

  parent_template :embedded

end

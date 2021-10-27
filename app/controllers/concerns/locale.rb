module Locale
  extend ActiveSupport::Concern

  included do
    before_action :set_locale

    # def self.default_url_options(options={})
    #   options.merge({ :locale => I18n.locale })
    # end
  end

  def set_locale
    I18n.locale = params[:locale].present? ? params[:locale] : I18n.default_locale
    Rails.application.routes.default_url_options[:locale] = I18n.locale
    # Rails.application.config.action_mailer.default_url_options[:locale] = I18n.locale
    # Rails.application.default_url_options[:locale] = I18n.locale
  end
end

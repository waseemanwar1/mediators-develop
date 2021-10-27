class Admin::Pages::Headers::TopbarItems::LanguageComponent < ViewComponent::Base

  def initialize(*)
    @locales = I18n.available_locales
    @default = I18n.default_locale
  end

private
  attr_reader :locales
end

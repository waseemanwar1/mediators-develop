class Admin::Tables::Fields::ColoredTextComponent < ViewComponent::Base
  def initialize(text, type:)
    @text, @type = text, type
  end

private
  attr_reader :text, :type
end

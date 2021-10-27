class Admin::Pages::Headers::Items::MenuItemComponent < ViewComponent::Base
  def initialize(url:, text:)
    @url, @text = url, text
  end

private
  attr_reader :url, :text
end

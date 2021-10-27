class Admin::Pages::Headers::TopbarItems::MenuComponent < ViewComponent::Base
  def initialize(text:,items: [])
    @text, @items = text, items
  end

private
  attr_reader :text, :items
end

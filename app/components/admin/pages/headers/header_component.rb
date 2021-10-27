class Admin::Pages::Headers::HeaderComponent < ViewComponent::Base

  def initialize(menus: [], items: [])
    @items, @menus = items, menus
  end

private
  attr_reader :items, :menus
end

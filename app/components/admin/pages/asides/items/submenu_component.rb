class Admin::Pages::Asides::Items::SubmenuComponent < ViewComponent::Base

  def initialize(text, icon: nil, items: [], show: true)
    @text, @icon, @items, @show = text, icon, items, show
  end

private
  attr_reader :text, :icon, :items, :show
end

class Admin::Pages::Asides::AsideComponent < ViewComponent::Base

  def initialize(actions: [], items: [])
    @actions, @items = actions, items
  end

private
  attr_reader :actions, :items
end

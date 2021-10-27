class Admin::Pages::Asides::Items::ItemComponent < ViewComponent::Base

  def initialize(text, icon: nil, url:, show: true)
    @text, @icon, @url, @show = text, icon, url, show
  end

private
  attr_reader :text, :icon, :url, :show
end

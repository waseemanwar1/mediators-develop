class Admin::Pages::Asides::Items::SubmenuItemComponent < ViewComponent::Base

  def initialize(text, url:, show: true)
    @text, @url, @show = text, url, show
  end

private
  attr_reader :text, :url, :show
end

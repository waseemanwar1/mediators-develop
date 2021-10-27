class Admin::Pages::Asides::Actions::IconLinkComponent < ViewComponent::Base
  # validates_presence_of :url, :icon

  def initialize(url:, icon:, show: true)
    @url, @icon, @show = url, icon, show
  end

private
  attr_reader :url, :icon, :show
end

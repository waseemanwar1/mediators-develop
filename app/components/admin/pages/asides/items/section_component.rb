class Admin::Pages::Asides::Items::SectionComponent < ViewComponent::Base

  def initialize(text, show: true)
    @text, @show = text, show
  end

private
  attr_reader :text, :show
end

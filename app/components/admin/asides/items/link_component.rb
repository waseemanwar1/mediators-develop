class Admin::Asides::Items::LinkComponent < ViewComponent::Base
  # validates_presence_of :url, :icon, :text

  def initialize(url:, icon:, text:, active: false)
    @url, @icon, @text, @active = url, icon, text, active
  end

private
  attr_reader :url, :icon, :text, :active
end

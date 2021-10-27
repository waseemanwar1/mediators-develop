class Admin::Pages::Headers::Items::LinkComponent < ViewComponent::Base
  # validates_presence_of :url, :icon, :text

  def initialize(url:, icon:, text:)
    @url, @icon, @text = url, icon, text
  end

private
  attr_reader :url, :icon, :text
end

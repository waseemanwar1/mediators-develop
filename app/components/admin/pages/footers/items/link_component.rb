class Admin::Pages::Footers::Items::LinkComponent < ViewComponent::Base
  # validates_presence_of :url, :text

  def initialize(url:, text:)
    @url, @text = url, text
  end

private
  attr_reader :url, :text
end

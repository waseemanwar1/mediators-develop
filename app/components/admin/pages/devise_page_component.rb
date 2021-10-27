class Admin::Pages::DevisePageComponent < ViewComponent::Base
  # validates :content, presence: true

  def initialize(header_link: nil)
    @header_link = header_link
  end

private
  attr_reader :header_link
end

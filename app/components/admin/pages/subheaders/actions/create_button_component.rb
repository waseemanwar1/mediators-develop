class Admin::Pages::Subheaders::Actions::CreateButtonComponent < ViewComponent::Base
  # validates :url, presence: true

  def initialize(url:)
    @url = url
  end

private
  attr_reader :url
end

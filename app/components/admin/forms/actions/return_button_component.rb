class Admin::Forms::Actions::ReturnButtonComponent < ViewComponent::Base

  # validates :url, presence: true

  def initialize(url:)
    @url = url
  end

private
  attr_reader :url
end

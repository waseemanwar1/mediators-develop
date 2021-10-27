class Admin::Tables::Actions::DestroyButtonComponent < ViewComponent::Base
  def initialize(url: nil)
    @url = url
  end

private
  attr_reader :url
end

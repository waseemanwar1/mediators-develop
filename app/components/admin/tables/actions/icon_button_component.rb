class Admin::Tables::Actions::IconButtonComponent < ViewComponent::Base
  def initialize(url:, icon:)
    @url, @icon = url, icon
  end

private
  attr_reader :url, :icon
end

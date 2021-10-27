class Admin::Calendars::Actions::CreateButtonComponent < ViewComponent::Base
  def initialize(url:)
    @url = url
  end

private
  attr_reader :url
end

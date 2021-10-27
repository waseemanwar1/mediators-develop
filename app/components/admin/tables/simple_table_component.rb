class Admin::Tables::SimpleTableComponent < ViewComponent::Base
  def initialize(headers: [])
    @headers = headers
  end

private
  attr_reader :headers
end

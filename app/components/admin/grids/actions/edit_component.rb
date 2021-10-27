class Admin::Grids::Actions::EditComponent < ViewComponent::Base
  # validates_presence_of :url

  def initialize(url: nil)
    @url = url
  end

private
  attr_reader :url
end

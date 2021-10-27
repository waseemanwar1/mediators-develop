class Admin::Tables::Fields::TagsComponent < ViewComponent::Base
  def initialize(tags)
    @tags = tags
  end

private
  attr_reader :tags
end

class Admin::Tables::Fields::IconComponent < ViewComponent::Base
  def initialize(resource, icon)
    @resource, @icon = resource, icon
  end

private
  attr_reader :resource, :icon
end

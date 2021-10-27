class Admin::Grids::Items::SimpleIconComponent < ViewComponent::Base
  # validates_presence_of :resource

  def initialize(resource:, icon:, actions: [])
    @resource, @icon, @actions = resource, icon, actions
  end

private
  attr_reader :resource, :actions, :icon
end

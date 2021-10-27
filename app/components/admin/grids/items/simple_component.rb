class Admin::Grids::Items::SimpleComponent < ViewComponent::Base
  # validates_presence_of :resource

  def initialize(resource:, actions: [])
    @resource, @actions = resource, actions
  end

private
  attr_reader :resource, :actions
end

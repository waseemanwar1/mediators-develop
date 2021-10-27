class Admin::Tables::Items::SimpleRowComponent < ViewComponent::Base
  def initialize(resource:, fields: [], actions: [])
    @resource, @fields, @actions = resource, fields, actions
  end

private
  attr_reader :resource, :fields, :actions
end

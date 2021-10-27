class Admin::Pages::Subheaders::SubheaderComponent < ViewComponent::Base

  def initialize(breadcrumbs: nil, actions: [])
    @breadcrumbs = breadcrumbs || Admin::Pages::Breadcrumbs::BreadcrumbComponent.new
    @actions = actions
  end
private
  attr_reader :breadcrumbs, :actions
end

class Admin::Pages::AdminPageComponent < ViewComponent::Base
  # validates :content, presence: true

  def initialize(breadcrumbs: nil, actions: [])
    @breadcrumbs = breadcrumbs
    @actions = actions
  end

private
  attr_reader :breadcrumbs, :actions
end

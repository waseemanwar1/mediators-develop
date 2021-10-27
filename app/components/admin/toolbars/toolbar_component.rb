class Admin::Toolbars::ToolbarComponent < ViewComponent::Base
  def initialize(query: nil, filters: [])
    @query, @filters = query, filters
  end

private
  attr_reader :query, :filters
end

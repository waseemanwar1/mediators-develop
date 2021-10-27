class Admin::Catalogs::CatalogComponent < ViewComponent::Base
  # validates_presence_of :container, :url, :pagination

  def initialize(container:, url:, pagination:, toolbar: nil)
    @container, @url, @toolbar, @pagination = container, url, toolbar, pagination
  end

private
  attr_reader :container, :url, :pagination, :toolbar
end

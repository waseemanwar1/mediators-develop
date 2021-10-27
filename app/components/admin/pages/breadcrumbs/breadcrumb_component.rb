class Admin::Pages::Breadcrumbs::BreadcrumbComponent < ViewComponent::Base

  def initialize(links: [], current: false)
    paths = CurrentAdmin.request.path.split('/')
    @current = current ? current : set_current(paths)
    @links = set_links(paths, links)
  end

private
  attr_reader :current, :links

  def set_current(paths)
    I18n.t("admin.component.breadcrumbs.#{paths[-1]}")
  end

  def base_link
    Admin::Pages::Breadcrumbs::Links::LinkComponent.new(url: CurrentAdmin.root_path, text: I18n.t("admin.component.breadcrumbs.home"))
  end

  def set_links(paths, links)
    all_links = []
    all_links << base_link if CurrentAdmin.request.path != CurrentAdmin.root_path.split('?')[0]
    links.each do |link|
      all_links << link
    end
    all_links
  end
end

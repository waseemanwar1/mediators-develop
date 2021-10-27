class Admin::Asides::AsideComponent < ViewComponent::Base

  def initialize(items: [])
    @avatar = CurrentAdmin.avatar
    @username = CurrentAdmin.username
    @groups = CurrentAdmin.groups.join(', ')
    @items = items
  end

private
  attr_reader :avatar, :username, :groups, :items
end

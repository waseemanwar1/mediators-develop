class Admin::Pages::Headers::TopbarItems::UserComponent < ViewComponent::Base

  def initialize(items: [], actions: [])
    @avatar = CurrentAdmin.avatar
    @title = CurrentAdmin.username
    @groups = CurrentAdmin.groups.join(', ')
    @items, @actions = items, actions
  end

private
  attr_reader :title, :groups, :items, :actions, :avatar
end

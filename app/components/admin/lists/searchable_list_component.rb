class Admin::Lists::SearchableListComponent < ViewComponent::Base

  def initialize(title:, url:, actions: nil)
    @title, @url, @actions = title, url, actions
  end

private
  attr_reader :title, :url, :actions
end

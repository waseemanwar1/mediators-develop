class Admin::Calendars::SimpleCalendarComponent < ViewComponent::Base
  def initialize(title:, actions: [])
    @title, @actions = title, actions
  end

private
  attr_reader :title, :actions
end

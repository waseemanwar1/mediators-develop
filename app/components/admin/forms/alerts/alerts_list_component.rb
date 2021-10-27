class Admin::Forms::Alerts::AlertsListComponent < ViewComponent::Base
  # validates :type, presence: true

  def initialize(alerts:, type:)
    @alerts = alerts
    @type = type
  end

private
  attr_reader :alerts, :type
end

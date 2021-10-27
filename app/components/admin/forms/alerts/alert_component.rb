class Admin::Forms::Alerts::AlertComponent < ViewComponent::Base
  # validates :type, presence: true

  def initialize(alert:, type:)
    @alert = alert
    @type = type
  end

private
  attr_reader :alert, :type
end

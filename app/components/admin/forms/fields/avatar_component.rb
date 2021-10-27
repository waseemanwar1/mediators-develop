class Admin::Forms::Fields::AvatarComponent < ViewComponent::Base

  attr_accessor :form
  # validates :field, :form, presence: true

  def initialize(field, label: nil, horizontal: true)
    @field, @label, @horizontal = field, label, horizontal
  end


private
  attr_reader :field, :horizontal, :label
end

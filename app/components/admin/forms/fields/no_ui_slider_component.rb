class Admin::Forms::Fields::NoUiSliderComponent < ViewComponent::Base
  attr_accessor :form
  # validates :field, :form, presence: true

  def initialize(field, label: nil, min: 0, max: 100, step: 1, start: 0, decimals: 0, horizontal: true, **options)
    options.merge!({ class: 'form-control kt-hide' })
    @field, @label, @min, @max, @step, @start, @decimals, @horizontal, @options = field, label, min, max, step, start, decimals, horizontal, options
  end

private
  attr_reader :field, :label, :min, :max, :step, :start, :decimals, :horizontal, :options
end

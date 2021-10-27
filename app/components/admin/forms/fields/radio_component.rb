class Admin::Forms::Fields::RadioComponent < ViewComponent::Base

  attr_accessor :form
  # validates :field, :form, presence: true

  def initialize(field, values: [], label: nil, horizontal: true, **options)
    options.merge!({ class: 'form-control' })
    @field, @values, @label, @horizontal, @options = field, values, label, horizontal, options
  end

private
  attr_reader :field, :values, :label, :horizontal, :options
end

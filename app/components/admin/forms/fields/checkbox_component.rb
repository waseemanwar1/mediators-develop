class Admin::Forms::Fields::CheckboxComponent < ViewComponent::Base

  attr_accessor :form
  # validates :field, :form, presence: true

  def initialize(field, label: nil, horizontal: true, **options)
    # options.merge!({ class: 'form-control' })
    @field, @label, @horizontal, @options = field, label, horizontal, options
  end

private
  attr_reader :field, :label, :horizontal, :options
end

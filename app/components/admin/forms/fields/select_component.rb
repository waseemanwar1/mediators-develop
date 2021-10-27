class Admin::Forms::Fields::SelectComponent < ViewComponent::Base

  attr_accessor :form
  # validates :field, :form, presence: true

  def initialize(field, values: [], label: nil, include_blank: false, horizontal: true, help: "", **options)
    options.merge!({ class: 'form-control kt-select2' })
    @field, @values, @label, @include_blank, @horizontal, @help, @options = field, values, label, include_blank, horizontal, help, options
  end

private
  attr_reader :field, :values, :label, :include_blank, :horizontal, :help, :options
end

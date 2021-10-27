class Admin::Forms::Fields::FileComponent < ViewComponent::Base

  attr_accessor :form
  # validates :field, :form, presence: true

  def initialize(field, label: nil, horizontal: true, **options)
    options.merge!({ class: 'custom-file-input' })
    @field, @label, @horizontal, @options = field, label, horizontal, options
  end

private
  attr_reader :field, :label, :horizontal, :options
end

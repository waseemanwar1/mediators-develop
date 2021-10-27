class Admin::Forms::Fields::TextComponent < ViewComponent::Base

  attr_accessor :form
  # validates :field, :form, presence: true

  def initialize(field, label: nil, mask: false, horizontal: true, **options)
    options.merge!({ class: 'form-control' })
    @field, @label, @mask, @horizontal, @options = field, label, mask, horizontal, options
  end

private
  attr_reader :field, :label, :mask, :horizontal, :options
end

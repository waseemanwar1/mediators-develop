class Admin::Forms::Fields::TagifyComponent < ViewComponent::Base

  attr_accessor :form
  # validates :field, :form, presence: true

  def initialize(field, label: nil, whitelist: false, horizontal: true, **options)
    options.merge!({ class: 'tagify tagify--outside' })
    @field, @label, @whitelist, @horizontal, @options = field, label, whitelist, horizontal, options
  end

private
  attr_reader :field, :label, :whitelist, :horizontal, :options
end

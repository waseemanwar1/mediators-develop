class Admin::Forms::Fields::QuillComponent < ViewComponent::Base
  attr_accessor :form

  def initialize(field, label: nil, horizontal: true, help: "", **options)
    options.merge!({ class: 'form-control' })
    @field, @label, @horizontal, @help, @options = field, label, horizontal, help, options
  end

private
  attr_reader :field, :label, :horizontal, :help, :options
end

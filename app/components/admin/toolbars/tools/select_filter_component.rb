class Admin::Toolbars::Tools::SelectFilterComponent < ViewComponent::Base

  def initialize(label:, field:, values: [], size: '2', include_blank: false, **options)
    options.merge!({ class: 'form-control bootstrap-select select-filter' })
    options.merge!({ include_blank: include_blank })
    options.merge!({ data: { action: 'admin--catalog#filter'} })
    @label, @field, @values, @size, @options = label, field, values, size, options
  end

private
  attr_reader :label, :field, :values, :size, :options
end

class Admin::Forms::Fields::DropzoneComponent < ViewComponent::Base

  attr_accessor :form
  # validates :field, :form, presence: true

  def initialize(field, label: nil, max_files: 1, max_file_size: 1, horizontal: true)
    @field, @label, @max_files, @max_file_size, @horizontal = field, label, max_files, max_file_size, horizontal
  end


private
  attr_reader :field, :label, :max_files, :max_file_size, :horizontal
end

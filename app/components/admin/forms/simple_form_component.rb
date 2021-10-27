class Admin::Forms::SimpleFormComponent < ViewComponent::Base

  # validates :resource, presence: true

  def initialize(url: nil, title: nil, subtitle: nil, resource:, fields: [], actions: [], alerts: [])
    @title, @subtitle, @resource, @fields, @actions, @alerts = title, subtitle, resource, fields, actions, alerts
    set_options(url)
  end

  def set_options(url)
    @options = {}
    @options[:url] = url if url
    @options[:html] = {class: 'kt-form kt-form--label-right'}
  end

private
  attr_reader :title, :subtitle, :resource, :fields, :actions, :options, :alerts
end

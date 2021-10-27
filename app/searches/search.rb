class Search

  def initialize(model:, params: {}, fields: [], extra: {})
    @model = model
    @params = params
    @extra = extra
    # @field = fields
  end

  def collection
    if @params[:where]
      where = WhereAdapter.not_nil(eval(@params[:where]).to_enum.to_h).merge!(@extra)
    else
      where = @extra
    end
    options = {}
    options[:page] = @params[:page] if @params[:page]
    options[:per_page] = @params[:per] if @params[:per]
    options[:order] = order if @params[:order] && @params[:order_by]
    options[:where] = where
    options[:match] = @params[:match].to_sym if @params[:match]
    # options[:fields] = @fields if @fields
    # options[:includes] = @model::INCLUDES rescue []
    @collection ||= @model.search(
      query,
      options
    )
  end

  # def count
  #   @count = @model.search(
  #     query,
  #     where: @where
  #   ).total_count
  # end

private
  def query
    @query ||= if @params[:query].present?
      escaped_characters = Regexp.escape('\\/+-&|!(){}[]^~*?:')
      @params[:query].gsub(/([#{escaped_characters}])/, '\\\\\1')
    else
      "*"
    end
  end

  def order
    { @params[:order_by] => @params[:order] }
  end
end

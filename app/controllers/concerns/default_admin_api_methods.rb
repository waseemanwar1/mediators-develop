module DefaultAdminApiMethods
  extend ActiveSupport::Concern

  included do
    def index
      if params[:elasticsearch] == "true"
        search = Search.new(
          model: resource_class,
          params: params,
        )
        collection = search.collection
      else
        collection = resource_class.order(id: :desc).page(params[:page])
      end
      respond_to do |format|
        # format.json { render json: search.collection }
        format.json { render json: "#{resource_class}Serializer".constantize.new(collection).serializable_hash }
      end
    end

    def show
      show! do |format|
        format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
      end
    end

    def create
      create! do |format|
        format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
      end
    end
  end
end

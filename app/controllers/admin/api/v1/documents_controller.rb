class Admin::Api::V1::DocumentsController < Admin::Api::V1::ApiController
  inherit_resources
  include DefaultAdminApiMethods
  include ApiCheckRelations
  before_action :authenticate_request!
  respond_to :json

  before_action :check_case_create, only: [:create]
  before_action :check_case_update, only: [:update]

  def index
    search = Search.new(
      model: resource_class,
      params: params,
      extra: { admin_user_id: CurrentAdmin.user.id }
    )
    respond_to do |format|
      format.json { render json: DocumentSerializer.new(search.collection).serializable_hash }
    end
  end

  def create
    @document = CurrentAdmin.user.documents.new(permitted_params[:document])
    create! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def show
    @document = CurrentAdmin.user.documents.find(params[:id])
    show! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def update
    @document = CurrentAdmin.user.documents.find(params[:id])
    update!
  end

  def destroy
    @document = CurrentAdmin.user.documents.find(params[:id])
    destroy!
  end

private
  def permitted_params
    params.permit(document:
      [
        :case_id,
        :file_name,
        :description,
        :date,
        :author,
        :file
      ]
    )
  end
end

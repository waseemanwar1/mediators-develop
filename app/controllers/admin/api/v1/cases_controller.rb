class Admin::Api::V1::CasesController < Admin::Api::V1::ApiController
  inherit_resources
  include DefaultAdminApiMethods
  before_action :authenticate_request!
  respond_to :json

  def index
    search = Search.new(
      model: resource_class,
      params: params,
      extra: { admin_user_id: CurrentAdmin.user.id }
    )
    respond_to do |format|
      format.json { render json: CaseSerializer.new(search.collection).serialized_json }
    end
  end

  def create
    @case = CurrentAdmin.user.cases.new(permitted_params[:case])
    create! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def show
    @case = CurrentAdmin.user.cases.find(params[:id])
    show! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def update
    @case = CurrentAdmin.user.cases.find(params[:id])
    update!
  end

  def destroy
    @case = CurrentAdmin.user.cases.find(params[:id])
    destroy!
  end

private
  def permitted_params
    params[:case][:tags] = params[:case][:tags].values if params[:case] && params[:case][:tags] && params[:case][:tags].is_a?(Hash)
    params.permit(case:
      [
        :program,
        :name,
        :description,
        :status,
        tags: []
      ]
    )
  end
end

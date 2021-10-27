class Admin::Api::V1::AgreementTemplatesController < Admin::Api::V1::ApiController
  inherit_resources
  include DefaultAdminApiMethods
  before_action :authenticate_request!
  respond_to :json

  def index
    search = Search.new(
      model: resource_class,
      params: params,
      extra: { public: true }
    )
    respond_to do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(search.collection).serializable_hash }
    end
  end

  def show
    @agreement_template = AgreementTemplate.where(public: true).find(params[:id])
    show! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end
end

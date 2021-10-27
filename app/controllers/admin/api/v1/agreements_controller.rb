class Admin::Api::V1::AgreementsController < Admin::Api::V1::ApiController
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
      format.json { render json: AgreementSerializer.new(search.collection).serializable_hash }
    end
  end

  def create
    @agreement = CurrentAdmin.user.agreements.new(permitted_params[:agreement])
    create! do |success, failure|
      success.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def show
    @agreement = CurrentAdmin.user.agreements.find(params[:id])
    show! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def update
    @agreement = CurrentAdmin.user.agreements.find(params[:id])
    update!
  end

  def destroy
    @agreement = CurrentAdmin.user.agreements.find(params[:id])
    destroy!
  end

  def send_document
    @agreement = CurrentAdmin.user.agreements.find(params[:id])
    sender = PdcFlowDocumentSender.new
    responce = sender.send(@agreement)
    if responce == "200"
      render json: {}, status: :ok
    else
      render json: { error: responce }, status: :bad_request
    end
  end

private
  def permitted_params
    params.permit(agreement:
      [
        :case_id,
        :agreement_template_id,
        :name,
        :content,
      ]
    )
  end
end

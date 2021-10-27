class Admin::Api::V1::PartiesController < Admin::Api::V1::ApiController
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
      format.json { render json: PartySerializer.new(search.collection).serializable_hash }
    end
  end

  def create
    @party = CurrentAdmin.user.parties.new(permitted_params[:party])
    create! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def show
    @party = CurrentAdmin.user.parties.find(params[:id])
    show! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def update
    @party = CurrentAdmin.user.parties.find(params[:id])
    update!
  end

  def destroy
    @party = CurrentAdmin.user.parties.find(params[:id])
    destroy!
  end

  def send_signature_request
    @party = CurrentAdmin.user.parties.find(params[:id])
    sender = PdcFlowSignatureSender.new
    responce = sender.send(@party.case.agreement, @party)
    if responce == "200"
      render json: {}, status: :ok
    else
      render json: { error: responce }, status: :bad_request
    end
  end

private
  def permitted_params
    params[:party][:tags] = params[:party][:tags].values if params[:party] && params[:party][:tags] && params[:party][:tags].is_a?(Hash)
    params.permit(party:
      [
        :case_id,
        :first_name,
        :last_name,
        :title,
        :company,
        :address,
        :notes,
        :email,
        :phone,
        :street,
        :city,
        :state,
        :zip_code,
        :country,
        tags: []
      ]
    )
  end
end

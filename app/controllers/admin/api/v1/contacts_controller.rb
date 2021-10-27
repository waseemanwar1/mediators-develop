class Admin::Api::V1::ContactsController < Admin::Api::V1::ApiController
  inherit_resources
  include DefaultAdminApiMethods
  # include ApiCheckRelations
  before_action :authenticate_request!
  respond_to :json

  # before_action :check_case_create, :check_party_create, only: [:create]
  # before_action :check_case_update, :check_party_update, only: [:update]

  def index
    search = Search.new(
      model: resource_class,
      params: params,
      extra: { admin_user_id: CurrentAdmin.user.id }
    )
    respond_to do |format|
      format.json { render json: ContactSerializer.new(search.collection).serializable_hash }
    end
  end

  def create
    @contact = CurrentAdmin.user.contacts.new(permitted_params[:contact])
    create! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def show
    @contact = CurrentAdmin.user.contacts.find(params[:id])
    show! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def update
    @contact = CurrentAdmin.user.contacts.find(params[:id])
    update!
  end

  def destroy
    @contact = CurrentAdmin.user.contacts.find(params[:id])
    destroy!
  end

private
  def permitted_params
    params[:contact][:tags] = params[:contact][:tags].values if params[:contact] && params[:contact][:tags] && params[:contact][:tags].is_a?(Hash)
    params[:contact][:case_ids] = params[:contact][:case_ids].values if params[:contact] && params[:contact][:case_ids]
    params[:contact][:party_ids] = params[:contact][:party_ids].values if params[:contact] && params[:contact][:party_ids]
    params.permit(contact:
      [
        :first_name,
        :last_name,
        :contact_type,
        :email,
        :title,
        :company,
        :phone,
        :address,
        :notes,
        :street,
        :city,
        :state,
        :zip_code,
        :country,
        tags: [],
        case_ids: [],
        party_ids: []
      ]
    )
  end
end

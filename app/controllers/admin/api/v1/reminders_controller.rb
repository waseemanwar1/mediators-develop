class Admin::Api::V1::RemindersController < Admin::Api::V1::ApiController
  inherit_resources
  include DefaultAdminApiMethods
  include ApiCheckRelations
  before_action :authenticate_request!
  respond_to :json

  before_action :check_case_create, :check_party_create, only: [:create]
  before_action :check_case_update, :check_party_update, only: [:update]

  def index
    search = Search.new(
      model: resource_class,
      params: params,
      extra: { admin_user_id: CurrentAdmin.user.id }
    )
    respond_to do |format|
      format.json { render json: ReminderSerializer.new(search.collection).serializable_hash }
    end
  end

  def create
    @reminder = CurrentAdmin.user.reminders.new(permitted_params[:reminder])
    create! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def show
    @reminder = CurrentAdmin.user.reminders.find(params[:id])
    show! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def update
    @reminder = CurrentAdmin.user.reminders.find(params[:id])
    update!
  end

  def destroy
    @reminder = CurrentAdmin.user.reminders.find(params[:id])
    destroy!
  end

private
  def check_case
    unless CurrentAdmin.user.cases.pluck(:id).include?(resource.case_id)
      render json: { error: "The case does not belong to this user" }, status: :bad_request
      return
    end
  end

  def check_party
    unless CurrentAdmin.user.parties.pluck(:id).include?(resource.party_id)
      render json: { error: "The party does not belong to this user" }, status: :bad_request
      return
    end
  end

  def permitted_params
    params.permit(reminder:
      [
        :case_id,
        :party_id,
        :contact_id,
        :name,
        :description,
        :priority,
        :due_date,
        :status,
      ]
    )
  end
end

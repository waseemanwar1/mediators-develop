class Admin::Api::V1::MessagesController < Admin::Api::V1::ApiController
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
      format.json { render json: MessageSerializer.new(search.collection).serializable_hash }
    end
  end

  def create
    @message = CurrentAdmin.user.messages.new(permitted_params[:message])
    @message.subject = "Case: #{@message.case_id}, #{@message.admin_user.username} message."
    @message.from = @message.admin_user.email
    @message.to = @message.party.email
    create! do |format|
      MessageMailer.send_message(@message.id).deliver_later
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def show
    @message = CurrentAdmin.user.messages.find(params[:id])
    show! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def update
    @message = CurrentAdmin.user.messages.find(params[:id])
    update!
  end

  def destroy
    @message = CurrentAdmin.user.messages.find(params[:id])
    destroy!
  end

private
  def permitted_params
    params.permit(message:
      [
        :case_id,
        :party_id,
        :subject,
        :sent_at,
        :content,
        :read,
        :from,
        :to,
      ]
    )
  end
end

class Admin::Api::V1::InvoicesController < Admin::Api::V1::ApiController
  inherit_resources
  include DefaultAdminApiMethods
  include ApiCheckRelations
  before_action :authenticate_request!, except: [:secret]
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
      format.json { render json: InvoiceSerializer.new(search.collection).serializable_hash }
    end
  end

  def create
    @invoice = CurrentAdmin.user.invoices.new(permitted_params[:invoice])
    create! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def show
    @invoice = CurrentAdmin.user.invoices.find(params[:id])
    show! do |format|
      format.json { render json: "#{resource_class}Serializer".constantize.new(resource).serializable_hash }
    end
  end

  def update
    @invoice = CurrentAdmin.user.invoices.find(params[:id])
    update!
  end

  def destroy
    @invoice = CurrentAdmin.user.invoices.find(params[:id])
    destroy!
  end

  def secret
    invoice_id = JsonWebToken.decode(request.headers[:token])[:invoice_id]
    render json: { secret: Invoice.find(invoice_id).stripe_client_secret }
  end

private
  def permitted_params
    params.permit(invoice:
      [
        :case_id,
        :party_id,
        :name,
        :time,
        :amount,
        :date,
        :due_date,
        :description
      ]
    )
  end
end

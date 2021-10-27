class Admin::MediatorsController < Admin::AdminController
  inherit_resources
  defaults :resource_class => AdminUser, :collection_name => 'admin_users', :instance_name => 'admin_user'
  include DefaultMethods

  def create
    create! do |success, failure|
      success.html do
        resource.groups << Group.find_by(name: 'Mediator')
        resource.save

        flash[:notice] = "#{t(resource_class.name.underscore.to_sym)} #{t('admin.component.alerts.successfull.create')}"
        redirect_to collection_url
      end
      failure.html do
        flash[:errors] = resource.errors.full_messages
        render :new
      end
    end
  end

  def update
    update! do |success, failure|
      success.html do
        flash[:notice] = "#{t(resource_class.name.underscore.to_sym)} #{t('admin.component.alerts.successfull.update')}"
        redirect_to collection_url
      end
      failure.html do
        flash[:errors] = resource.errors.full_messages
        render :edit
      end
    end
  end

  def destroy
    destroy! do |success, failure|
      success.html do
        flash[:notice] = "#{t(resource_class.name.underscore.to_sym)} #{t('admin.component.alerts.successfull.destroy')}"
        redirect_to collection_url
      end
      failure.html do
        flash[:errors] = resource.errors.full_messages
        redirect_to collection_url
      end
    end
  end

  def search
    search = Search.new(
      model: resource_class,
      params: params,
      extra: { group_ids: Group.find_by(name: 'Mediator').id }
    )
    respond_to do |format|
      format.html { render partial: "search", locals: { items: search.collection } }
    end
  end

private
  def permitted_params
    if params[:admin_user] && params[:admin_user][:password].blank? && params[:admin_user][:password_confirmation].blank?
        params[:admin_user].delete(:password)
        params[:admin_user].delete(:password_confirmation)
    end
    params.permit(admin_user:
      [
        :avatar, :email, :first_name,
        :last_name, :password, :password_confirmation,
        :hourly_rate, :company_name, :phone,
        :company_website, :address_line_1, :address_line_2,
        :postcode, :city, :state,
        :country, :billing_address_line_1, :billing_address_line_2,
        :billing_postcode, :billing_city, :billing_state,
        :billing_country, :subscription_paid, :active
      ]
    )
  end
end

class Admin::AdminUsersController < Admin::AdminController
  inherit_resources
  include DefaultMethods

  def search
    if params[:elasticsearch] == "true"
      search = Search.new(
        model: resource_class,
        params: params,
        extra: {
          group_ids: params[:group]
        }
      )
      collection = search.collection
    else
      collection = resource_class.joins(:groups).where('groups.id = ?', params[:group]).order(id: :desc).page(params[:page])
    end
    respond_to do |format|
      format.html { render partial: "search", locals: { items: collection } }
    end
  end

  def create
    @admin_user = AdminUser.new(permitted_params[:admin_user])

    create! do |success, failure|
      success.html do
        # Set group
        @admin_user.groups << Group.find(params[:group])
        @admin_user.save

        flash[:notice] = "#{Group.find(params[:group]).name} #{t('admin.component.alerts.successfull.create')}"
        redirect_to admin_admin_users_path(group: params[:group])
      end
      failure.html do
        flash[:errors] = resource.errors.full_messages
        redirect_to new_admin_admin_user_path(group: params[:group])
      end
    end
  end

  def update
    update! do |success, failure|
      success.html do
        flash[:notice] = "#{Group.find(params[:group]).name} #{t('admin.component.alerts.successfull.update')}"
        redirect_to admin_admin_users_path(group: params[:group])
      end
      failure.html do
        flash[:errors] = resource.errors.full_messages
        redirect_to edit_admin_admin_user_path(group: params[:group])
      end
    end
  end

  def destroy
    permission = Permission.find_by_key('permission_settings')
    groups = permission.groups
    users = AdminUser.joins(:groups).where( groups: { id: groups.pluck(:id) } )

    if users.count == 1 && users.first == resource
      flash[:alert] = t('admin.component.alerts.last_user')
      redirect_to admin_admin_users_path(group: params[:group])
    else
      destroy! do |format|
        format.html { redirect_to admin_admin_users_path(group: params[:group]) }
      end
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

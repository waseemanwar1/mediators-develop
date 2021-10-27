class Admin::PermissionsController < Admin::AdminController
  def index
  end

  def search_admin_users
    @admin_users = AdminUser.search(params[:search], match: 'word_start')
    render partial: 'admin/permissions/admin_user', collection: @admin_users
  end

  def search_groups
    @groups = Group.search(params[:search], match: 'word_start')
    render partial: 'admin/permissions/group', collection: @groups
  end

  def search_permissions
    @permissions = Permission.search(params[:search], match: 'word_start')
    render partial: 'admin/permissions/permission', collection: @permissions
  end

  def get_references
    render json: params[:model].classify.constantize.find(params[:id]).permission_references
  end

  def add_references
    object = params[:model].classify.constantize.find(params[:id])
    set_object = params[:set_model].classify.constantize.find(params[:set_id])
    object.send(params[:set_model]) << set_object
    object.save
    render json: {}, status: 200
  end

  def remove_references
    object = params[:model].classify.constantize.find(params[:id])
    set_object = params[:set_model].classify.constantize.find(params[:set_id])

    object.send(params[:set_model]).delete(set_object)
    object.save
    validate_last_user(object, set_object)
  end

private
  def validate_last_user(object, set_object)
    permission = Permission.find_by_key('permission_settings')
    groups = permission.groups
    users = AdminUser.joins(:groups).where( groups: { id: groups.pluck(:id) } )

    if users.count == 0
      object.send(params[:set_model]) << set_object
      object.save
      render json: { errors: [{ type: 'info', text: t('admin.component.alerts.last_user') }] }, status: 500
    else
      render json: params[:model].classify.constantize.find(params[:id]).permission_references, status: 200
    end
  end
end

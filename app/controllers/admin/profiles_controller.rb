class Admin::ProfilesController < Admin::AdminController
  def my
    @user = CurrentAdmin.user
  end

  def update
    @user = CurrentAdmin.user
    if @user.update(admin_user_params)
      redirect_to my_admin_profile_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to my_admin_profile_path
    end
  end

  def settings
  end

private
  def admin_user_params
    params.require(:admin_user).permit(
      :avatar, :email, :first_name,
      :last_name
    )
  end
end

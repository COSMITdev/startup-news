class Users::RegistrationsController < Devise::RegistrationsController
  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    if current_user.update_attributes(account_update_params)
      set_flash_message :notice, :updated if is_flashing_format?
      sign_in(current_user, bypass: true)
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end
end

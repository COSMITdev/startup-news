class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env["omniauth.auth"]
    authentication = Authentication.where(provider: auth.provider, uid: auth.uid).first
    @user = User.create_with_facebook(auth) unless @user = authentication.try(:user)
    if @user.persisted?
      set_flash_message(:notice, :success, kind: "Facebook") if is_flashing_format?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.facebook_data"] = auth
      redirect_to new_user_registration_url
    end
  end
end

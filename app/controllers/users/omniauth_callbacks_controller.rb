class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @auth = request.env["omniauth.auth"]
    @authentication = Authentication.where(provider: @auth.provider, uid: @auth.uid)
    @user = User.where(email: @auth.info.email)

    if @authentication.any?
      if @authentication.first.user.persisted?
        sign_in_and_redirect @authentication.first.user, event: :authentication
        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      end
    else
      if @user.any?
        @authenticated_user = @user.first.create_authentication(provider: @auth.provider, uid: @auth.uid)
        sign_in_and_redirect @authenticated_user.user, event: :authentication
        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      else
        password = Devise.friendly_token[0,20]
        user = User.create!(username:@auth.info.nickname.gsub('.', ''),
                           email:@auth.info.email,
                           password:password,
                           password_confirmation:password
                          )
        sign_in_and_redirect user, event: :authentication
        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
        # session["devise.facebook_data"] = @auth.except("extra")
        # redirect_to new_user_registration_url
      end
    end
  end
end

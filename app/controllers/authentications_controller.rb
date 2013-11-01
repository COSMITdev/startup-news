class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!

  inherit_resources
  actions :destroy

  def destroy
    destroy! do |format|
      format.html { redirect_to edit_user_registration_url }
    end
  end

  protected

  def permitted_params
    params.permit(authentication: [:uid, :provider])
  end
end

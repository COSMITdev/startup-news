class PagesController < ApplicationController
  def about
  end

  def contact
  end

  def dispatch_email
    user_info = params[:user_info]
    Contact.send_email(user_info).deliver!
    redirect_to root_path, notice: I18n.t('pages.dispatch_email.success_message')
  end
end

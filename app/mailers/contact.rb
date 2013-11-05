class Contact < ActionMailer::Base
  default from: "no-reply@codeland.com.br"

  def send_email(user_info)
    @user_info = user_info
    mail(
      to: "contato@codeland.com.br",
      subject: "Contato StartupNews",
      date: Time.now,
      content_type: "text/html"
    )
  end
end

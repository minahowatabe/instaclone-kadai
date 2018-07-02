class NoticeMailer < ApplicationMailer
  def contact_mail(user)
    @user = user
    mail to: @user.email, subject: "you just posted!"
  end
end

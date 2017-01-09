class ApplicationMailer < ActionMailer::Base
  default from: 'vtungcntt12t1@gmail.com'

  def new_word_email(user, word)
    @user = user
    mail(
      to: user.email,
      subject: "New word on the E-learning"
    )
  end

  layout 'mailer'
end


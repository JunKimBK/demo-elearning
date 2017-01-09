class WordMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.word_mailer.send_word_email.subject
  #
  def send_word_email user
    @user = user
    mail to: user.email, subject: "You received a new word from E-learning"
  end
end

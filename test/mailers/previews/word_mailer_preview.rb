# Preview all emails at http://localhost:3000/rails/mailers/word_mailer
class WordMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/word_mailer/send_word_email
  def send_word_email
    WordMailer.send_word_email
  end

end

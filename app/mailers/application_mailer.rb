class ApplicationMailer < ActionMailer::Base
  default from: ENV["SENDGRID_EMAIL_FROM"]
  layout 'mailer'
end

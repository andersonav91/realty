ActionMailer::Base.register_interceptor(SendGrid::MailInterceptor)

ActionMailer::Base.smtp_settings = {
    :address => 'smtp.sendgrid.net',
    :port => '25',
    :domain => 'examepl',
    :authentication => :plain,
    :user_name => ENV['SENDGRID_USER_NAME'],
    :password => ENV['SENDGRID_PASSWORD']
}

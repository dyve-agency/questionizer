url_options = {
  'development' => {:host => "localhost"},
  'test'        => {:host => "localhost"},
  'production'  => {:host => 'www.yourdomain.com'}
}

ActionMailer::Base.default_url_options       = url_options[Rails.env]
Rails.application.routes.default_url_options = url_options[Rails.env]
Rails.application.config.default_url_options = url_options[Rails.env]

case Rails.env
when "test"
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.delivery_method = :test

when "development"
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = { :address => "localhost", :port => 1025 }
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.perform_deliveries = true
  # ActionMailer::Base.perform_deliveries = false
  # class OverrideMailReciptient
  #   def self.delivering_email(mail)
  #     mail.subject = "#{Time.now.to_i.to_s} - #{mail.subject}"
  #     mail.to = %W(app_developer_account@gmail.com another_app_developer@hotmail.com)
  #   end
  # end
  # ActionMailer::Base.register_interceptor(OverrideMailReciptient)
when "production"
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address => Rails.application.secrets.mail_smtp_address,
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true,
    :user_name => Rails.application.secrets.mail_user_name,
    :password =>  Rails.application.secrets.mail_password
  }
end


# TO USE GOOGLE APPS:
# =============================================================
# ActionMailer::Base.smtp_settings = {
#   :address => "smtp.gmail.com",
#   :port => 587,
#   :authentication => :plain,
#   :domain => 'gmail.com',
#   :enable_starttls_auto => true,
#   :user_name => "noreply@example.com",
#   :password => "PASSWORD"
# }
#
#
# TO USE GMAIL:
# =============================================================
#  config.action_mailer.smtp_settings = {
#    :address        => 'smtp.gmail.com',
#    :port           => 587,
#    :authentication => 'plain',
#    :user_name      => 'info@example.com',
#    :password       => 'PASSWORD',
#    :enable_starttls_auto => true
#  }
#
#
# TO USE AMAZON SES
# =============================================================
# aws_config = Rails.application.secrets.amazon
# ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
#   :access_key_id     => aws_config['access_key_id'],
#   :secret_access_key => aws_config['secret_access_key']
# ActionMailer::Base.delivery_method = :ses


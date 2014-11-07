class NotificationMailer < ActionMailer::Base
  default :from => '"Questionizer" <info@zeit.io>'
  def list_answered(list)
    @list = list
    return unless @list.emails_to_notify.present?
    mail(:to => @list.emails_to_notify, :subject => "[Questionizer] List Answered #{DateTime.now.stamp("1999-12-31 23:59:59")}")
  end
end

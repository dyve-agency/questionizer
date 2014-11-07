class TestMailer < ActionMailer::Base
  default :from => '"Darth Vader" <vader@deathstar.imp>'
  def test(user)
    mail(:to => user.email, :subject => "[Rails Blank App] Testing #{DateTime.now.stamp("1999-12-31 23:59:59")}")
  end
end

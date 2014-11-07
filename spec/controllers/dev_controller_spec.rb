
require 'spec_helper'

describe DevController do

  describe "The application can test how emails are sent" do
    it "sends a test email" do
      request.env["HTTP_REFERER"] = "/" # so the redirect_to :back doesn't break the test
      get 'send_test_mail'
      emails = ActionMailer::Base.deliveries
      expect(emails.length).to eq(1)
      expect(emails.first.subject).to match(/\[Rails Blank App\] Testing/)
    end
  end

end

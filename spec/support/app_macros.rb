module AppMacros
  def logged_in_user
    user = FactoryGirl.create(:user)
    visit dev_path("impersonate", :user_id => user.id)
    user
  end
end

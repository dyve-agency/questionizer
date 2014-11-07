FactoryGirl.define do

  sequence(:email){|n| "user#{n}@test.com" }

  factory :user do
    locale 'en'
    email { FactoryGirl.generate(:email)}
    password 'qweqweqwe'
    # terms_of_service "1"
    # confirmed_at Time.now
  end
end

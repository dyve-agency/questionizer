# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :list do
    uuid "MyString"
    emails_to_notify "MyText"
  end
end

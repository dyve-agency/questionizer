# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    belongs_to ""
    body "MyText"
    reply "MyText"
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
    email "user@example.com"
    password "MyString"
    password_confirmation "MyString"
  end
end

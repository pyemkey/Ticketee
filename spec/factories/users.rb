# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@xample.com" }
  factory :user do
    name "MyString"
    email { generate(:email) } 
    password "MyString"
    password_confirmation "MyString"

    factory :admin_user do
      admin true
    end
  end
end

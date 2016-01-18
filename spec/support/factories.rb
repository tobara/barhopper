FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "PabloEscobar#{n}" }
    sequence(:email) { |n| "pablo#{n}@columbia.com" }
    password 'password'
    password_confirmation 'password'
  end
end

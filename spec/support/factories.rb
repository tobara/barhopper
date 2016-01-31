FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "PabloEscobar#{n}" }
    sequence(:email) { |n| "pablo#{n}@columbia.com" }
    password 'password'
    password_confirmation 'password'
  end
end

FactoryGirl.define do
  factory :bar do
    sequence(:name) { |n| "Corner Tavern#{n}" }
    sequence(:location) { |n| "Back Bay#{n}" }
    sequence(:address) { |n| "421 Marlborough St, Boston, MA 0211#{n}" }

    association :user, factory: :user
  end
end

FactoryGirl.define do
  factory :comment do
    sequence(:description) { |n| "Best Bar#{n}" }
    sequence(:rating) { |n| "#{n}" }
    sequence(:bar_id) { |n| "#{n}" }
    sequence(:user_id) { |n| "#{n}" }

    association :bar, factory: :bar
    association :user, factory: :user
  end
end

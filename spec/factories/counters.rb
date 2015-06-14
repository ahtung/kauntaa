FactoryGirl.define do
  factory :counter do
    name { Faker::Name.name }
    value 0
    palette

    trait :with_user do
      user
    end
    trait :a_month_older do
      created_at { Time.zone.now - 1.month }
    end
  end
end

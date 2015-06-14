FactoryGirl.define do
  factory :counter do
    name { Faker::Name.name }
    value { Faker::Number.number(2) }
    palette

    trait :with_user do
      user
    end
    trait :a_month_older do
      created_at { Time.zone.now - 1.month }
    end
  end
end

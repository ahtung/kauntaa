FactoryGirl.define do
  factory :counter do
    name { Faker::Name.name }
    value 29

    trait :a_month_older do
      created_at { Time.now - 1.month }
    end
  end
end

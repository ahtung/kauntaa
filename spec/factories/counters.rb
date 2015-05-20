FactoryGirl.define do
  factory :counter do
    name { Faker::Name.name }
    value 29
    palette

    trait :a_month_older do
      created_at { Time.zone.now - 1.month }
    end
  end
end

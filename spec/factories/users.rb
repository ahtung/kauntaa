FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
  end

  trait :with_counter_a_month_old do
    counters { create_list(:counter, 1, :a_month_older) }
  end
end

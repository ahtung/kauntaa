FactoryGirl.define do
  factory :counter do
    name { Faker::Name.name }
    value 29
  end
end

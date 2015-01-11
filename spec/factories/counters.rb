FactoryGirl.define do
  factory :counter do
    name { Faker::Name.name }
    value 0
  end
end

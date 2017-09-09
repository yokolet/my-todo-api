FactoryGirl.define do
  factory :todo do
    title { Faker::Hacker.verb }
    created_by { Faker::Number.number(10) }
  end
end

FactoryBot.define do
  factory :merchant do
    name { Faker::Name.first_name }
    description { Faker::Lorem.sentence }
    sequence(:email) { |n| "merchant#{n}@example.com" }
  end

  trait :inactive_merchant do
    status { 1 }
  end

  trait :with_transactions do
    after(:build) do |ecr|
      ecr.transactions << build(:transaction)
    end
  end

  trait :admin_merchant do
    is_admin { true }
  end
end

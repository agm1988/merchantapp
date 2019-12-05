FactoryBot.define do
  factory :merchant do
    name { "MyText" }
    description { "MyText" }
    email { "MyString" }
    status { 1 }
    total_transaction_sum { "9.99" }
  end

  trait :with_transactions do
    after(:build) do |ecr|
      ecr.transactions << build(:transaction)
    end
  end
end

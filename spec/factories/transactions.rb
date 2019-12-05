FactoryBot.define do
  factory :transaction do
    merchant
    uuid { SecureRandom.uuid }
    amount { rand(100_000_00) / 100.0 }
    type { '' }
  end

  trait :error_transaction do
    status { 1 }
  end

  trait :initial_transaction do
    type { 'InitialTransaction' }
  end

  trait :settlement_transaction do
    type { 'SettlementTransaction' }
  end

  trait :refund_transaction do
    type { 'RefundTransaction' }
  end

  trait :invalidation_transaction do
    type { 'InvalidationTransaction' }
  end
end

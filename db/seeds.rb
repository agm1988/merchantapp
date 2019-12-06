# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# admin
Merchant.create!(name: Faker::Name.first_name,
                 description: Faker::Lorem.sentence,
                 email: 'admin@example.com',
                 status: :active,
                 is_admin: true,
                 password: '11111111',
                 password_confirmation: '11111111')

10.times do |i|
  merchant = Merchant.create!(name: Faker::Name.first_name,
                              description: Faker::Lorem.sentence,
                              email: "merchant#{i}@example.com",
                              status: Merchant::STATUSES.shuffle.last,
                              password: '11111111',
                              password_confirmation: '11111111')

  initial_transaction = InitialTransaction.create!(amount: rand(100_000) / 100.0,
                                                   status: Transaction::STATUSES.shuffle.last,
                                                   merchant_id: merchant.id)

  settlement_transaction = SettlementTransaction.create!(amount: rand(100_000) / 100.0,
                                                         status: Transaction::STATUSES.shuffle.last,
                                                         reference_uuid: initial_transaction.reload.uuid,
                                                         merchant_id: merchant.id)

  next if i.even?

  RefundTransaction.create!(amount: rand(100_000) / 100.0,
                            status: Transaction::STATUSES.shuffle.last,
                            reference_uuid: settlement_transaction.reload.uuid,
                            merchant_id: merchant.id)
end

5.times do |i|
  merchant = Merchant.create!(name: Faker::Name.first_name,
                              description: Faker::Lorem.sentence,
                              email: "merchant_declined#{i}@example.com",
                              status: Merchant::STATUSES.shuffle.last,
                              password: '11111111',
                              password_confirmation: '11111111')

  initial_transaction = InitialTransaction.create!(amount: rand(100_000) / 100.0,
                                                   status: Transaction::STATUSES.shuffle.last,
                                                   merchant_id: merchant.id)

  InvalidationTransaction.create!(amount: rand(100_000) / 100.0,
                                  status: Transaction::STATUSES.shuffle.last,
                                  reference_uuid: initial_transaction.reload.uuid,
                                  merchant_id: merchant.id)
end

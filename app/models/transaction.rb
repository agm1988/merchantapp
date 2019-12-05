class Transaction < ApplicationRecord
  belongs_to :merchant

  belongs_to :reference, class_name: 'Transaction',
                         primary_key: :reference_uuid,
                         optional: true
  has_one :dependent, class_name: 'Transaction',
                      foreign_key: :reference_uuid
end

# frozen_string_literal: true

class Transaction < ApplicationRecord
  STATUSES = %i[processed error].freeze

  belongs_to :merchant

  belongs_to :reference, class_name: 'Transaction',
                         primary_key: :uuid,
                         foreign_key: :reference_uuid,
                         optional: true

  has_one :dependent, class_name: 'Transaction',
                      foreign_key: :reference_uuid,
                      primary_key: :uuid

  validates :amount, :status, presence: true

  enum status: STATUSES

  scope :processed, -> { where(status: :processed) }
  scope :error, -> { where(status: :error) }
end

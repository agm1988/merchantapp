class Merchant < ApplicationRecord
  STATUSES = %i[active inactive].freeze

  has_secure_password

  has_many :transactions

  validates :email, uniqueness: { case_sensitive: false }
  validates :name, :description, :email, :status, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum status: STATUSES
end

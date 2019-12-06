class Merchant < ApplicationRecord
  STATUSES = %i[active inactive].freeze

  has_secure_password

  paginates_per 10

  has_many :transactions, dependent: :destroy

  validates :email, uniqueness: { case_sensitive: false }
  validates :name, :description, :email, :status, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  enum status: STATUSES
end

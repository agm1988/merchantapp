class Merchant < ApplicationRecord
  STATUSES = %i[active inactive].freeze

  has_secure_password

  # https://github.com/rails/rails/issues/14365
  has_many :transactions, dependent: :destroy,
                          after_add: :recalculate_transactions_total_sum

  validates :email, uniqueness: { case_sensitive: false }
  validates :name, :description, :email, :status, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  enum status: STATUSES

  scope :active, -> { where(status: :active) }
  scope :inactive, -> { where(status: :inactive) }

  private

  # do we need to subtract refund transaction?
  def recalculate_transactions_total_sum(_merchant)
    total_amount = transactions.sum(:amount)

    update_column(:total_transaction_sum, total_amount)
  end
end

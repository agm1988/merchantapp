# frozen_string_literal: true

module AuthenticationService
  def self.call(headers = nil)
    return Applicative::None.new('X-Access-Token') unless headers && headers.key?('X-Access-Token')
    merchant_id = JsonWebToken.decode(headers['X-Access-Token'])['merchant_id']

    Applicative::Some.new(Merchant.find(merchant_id))
  rescue JWT::VerificationError, JWT::ExpiredSignature, ActiveRecord::RecordNotFound => e
    Applicative::None.new(e.message)
  end
end

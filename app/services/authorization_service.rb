# frozen_string_literal: true

module AuthorizationService
  def self.call(params)
    merchant = Merchant.find_by(email: params[:email])

    if merchant&.authenticate(params[:password])
      payload = { merchant_id: merchant.id, name: merchant.name }

      Applicative::Some.new(JsonWebToken.encode(payload))
    else
      Applicative::None.new('Invalid credentials')
    end
  rescue => e
    Applicative::None.new(e.message)
  end
end

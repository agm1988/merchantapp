# frozen_string_literal: true

module RequestHelper
  def authenticate_headers_for(merchant)
    header 'X-Access-Token', jwt_for_merchant(merchant)
  end

  def jwt_for_merchant(merchant)
    payload = { merchant_id: merchant.id, name: merchant.name }

    JsonWebToken.encode(payload)
  end
end

RSpec.configure do |config|
  config.include RequestHelper, type: :api
end

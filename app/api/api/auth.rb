# frozen_string_literal: true

module Api
  class Auth < Grape::API
    version 'v1', using: :header, vendor: 'merchantpay'

    post 'auth/authorize' do
      result = AuthorizationService.call(params)

      if result.some?
        status 200
        { jwt: result.value }
      else
        error!(result.value, 401)
      end
    end

    desc 'Api status'
    post '/status' do
      status :ok
      { status: :ok }
    end
  end
end

# frozen_string_literal: true

module Api
  class Base < Grape::API
    content_type :json, 'application/json;charset=UTF-8'
    format :json

    helpers do
      def authenticate!(headers)
        result = AuthenticationService.call(headers)
        error!(result.value, 401) unless result.some?
        result.value
      end

      def authenticate_admin!(_headers)
        error!('Admin restricted', 403) unless current_merchant.is_admin?
      end

      def current_merchant
        @current_merchant ||= authenticate!(headers)
      end
    end

    mount Api::Merchants => '/v1'
    mount Api::Transactions => '/v1'
    mount Api::Auth => '/v1'

    desc 'Return pong if everything is ok'
    post '/ping' do
      'pong'
    end

    use Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post put delete options]
      end
    end

    route :any, '*path' do
      error!('not found', 404)
    end
  end
end

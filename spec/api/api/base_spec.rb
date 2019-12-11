# frozen_string_literal: true

require 'rails_helper'

describe Api::Base, type: :api do
  let!(:merchant) do
    create(:merchant,
           email: 'merchant@example.com',
           password: 'secure pwd',
           password_confirmation: 'secure pwd')
  end

  specify 'requests X-Access-Token' do
    post 'api/v1/transactions/accept_payment', {}

    resp = JSON.parse(last_response.body)

    expect(last_response.status).to be 401
    expect(resp['error']).to eq('Not set X-Access-Token')
  end
end

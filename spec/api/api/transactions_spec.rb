# frozen_string_literal: true

require 'rails_helper'

describe Api::Transactions, type: :api do
  let!(:merchant) do
    create(:merchant)
  end

  describe 'POST /api/v1/transactions/accept_payment' do
    let(:payload) do
      {
        status: 'processed',
        amount: 10_000
      }
    end

    before do
      authenticate_headers_for(merchant)
    end

    specify 'response successfull' do
      post 'api/v1/transactions/accept_payment', payload

      expect(last_response.status).to be 201
    end

    specify 'creates transaction' do
      expect { post 'api/v1/transactions/accept_payment', payload }
        .to change(merchant.transactions, :count).by(1)
    end
  end
end

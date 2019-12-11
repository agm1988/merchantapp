# frozen_string_literal: true

require 'rails_helper'

describe Api::Merchants, type: :api do
  let!(:admin) do
    create(:merchant,
           :admin_merchant,
           email: 'admin@example.com')
  end

  let!(:merchant) do
    create(:merchant,
           email: 'merchant@example.com')
  end

  let!(:second_merchant) { create(:merchant) }

  describe 'GET /api/v1/merchants' do
    context 'authorized admin' do
      before do
        authenticate_headers_for(admin)
        get '/api/v1/merchants'
      end

      specify 'response successfull' do
        expect(last_response.status).to be 200
      end

      specify 'returns merchants list' do
        resp = JSON.parse(last_response.body)

        expect(resp.size).to eq(3)
      end
    end

    context 'authorized merchant' do
      before do
        authenticate_headers_for(merchant)
        get '/api/v1/merchants'
      end

      it_behaves_like 'admin restricted area'
    end
  end

  describe 'GET /api/v1/merchants show' do
    context 'authorized admin' do
      before do
        authenticate_headers_for(admin)
        get "/api/v1/merchants/#{merchant.id}"
      end

      specify 'response successfull' do
        expect(last_response.status).to be 200
      end

      specify 'returns merchant\'s data' do
        resp = JSON.parse(last_response.body)

        expect(resp['id']).to eq(merchant.id)
        expect(resp['name']).to eq(merchant.name)
        expect(resp['description']).to eq(merchant.description)
        expect(resp['email']).to eq(merchant.email)
        expect(resp['status']).to eq(merchant.status)
        expect(resp['is_admin']).to eq(merchant.is_admin)
        expect(resp['total_transaction_sum'])
          .to eq(merchant.total_transaction_sum.to_s)
        expect(resp['transactions']).to eq([])
      end
    end

    context 'authorized merchant' do
      before do
        authenticate_headers_for(merchant)
        get "/api/v1/merchants/#{second_merchant.id}"
      end

      it_behaves_like 'admin restricted area'
    end
  end

  describe 'PUT /api/v1/merchants update' do
    context 'authorized admin' do
      before do
        authenticate_headers_for(admin)
        put "/api/v1/merchants/#{merchant.id}", name: 'updated'
      end

      specify 'response successfull' do
        expect(last_response.status).to be 200
      end

      specify 'updates merchant' do
        expect(merchant.reload.name).to eq('updated')
      end
    end

    context 'authorized merchant' do
      before do
        authenticate_headers_for(merchant)
        put "/api/v1/merchants/#{merchant.id}", name: 'updated'
      end

      it_behaves_like 'admin restricted area'
    end
  end

  describe 'DELETE /api/v1/merchants ' do
    context 'authorized admin' do
      before do
        authenticate_headers_for(admin)
      end

      specify 'response successfull' do
        delete "/api/v1/merchants/#{merchant.id}"

        expect(last_response.status).to be 200
      end

      specify 'delete merchant' do
        expect { delete "/api/v1/merchants/#{merchant.id}" }
          .to change(Merchant, :count).by(-1)
      end
    end

    context 'authorized merchant' do
      before do
        authenticate_headers_for(merchant)
        delete "/api/v1/merchants/#{merchant.id}"
      end

      it_behaves_like 'admin restricted area'
    end
  end
end

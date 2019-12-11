# frozen_string_literal: true

require 'rails_helper'

describe Api::Auth, type: :api do
  let!(:admin) do
    create(:merchant,
           :admin_merchant,
           email: 'admin@example.com',
           password: 'secure pwd',
           password_confirmation: 'secure pwd')
  end

  let!(:merchant) do
    create(:merchant,
           email: 'merchant@example.com',
           password: 'secure pwd',
           password_confirmation: 'secure pwd')
  end

  describe 'POST /api/v1/auth/authorize' do
    before do
      post('/api/v1/auth/authorize', payload)
    end

    let(:payload) do
      {
        email: email,
        password: password
      }
    end

    context 'merchant authorized' do
      let(:password) { 'secure pwd' }

      context 'admin merchant' do
        let(:email) { admin.email }

        context 'with valid params' do
          it 'is successful' do
            expect(last_response).to be_successful
          end

          it 'has authentication_token' do
            resp = JSON.parse(last_response.body)

            expect(resp['jwt']).to be_present
          end
        end
      end

      context 'merchant' do
        let(:email) { merchant.email }
        let(:password) { 'secure pwd' }

        context 'with valid params' do
          it 'is successful' do
            expect(last_response).to be_successful
          end

          it 'has authentication_token' do
            resp = JSON.parse(last_response.body)

            expect(resp['jwt']).to be_present
          end
        end
      end
    end

    context 'merchant not authorized' do
      let(:email) { merchant.email }
      let(:password) { 'wrong' }

      specify do
        expect(last_response.status).to be 401
      end
    end
  end
end

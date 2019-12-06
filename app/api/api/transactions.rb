# frozen_string_literal: true
module Api
  class Transactions < Grape::API
    version 'v1', using: :header, vendor: 'merchantpay'

    resources :transactions do
      before do
        authenticate!(headers)
      end

      desc 'accept payment'
      params do
        requires :status,
                 type: String,
                 values: %w(processed error)
        requires :amount,
                 type: BigDecimal
        optional :type,
                 type: String,
                 values: %w[InitialTransaction InvalidationTransaction
                            RefundTransaction SettlementTransaction]
        optional :reference_uuid,
                 type: String
      end

      post '/accept_payment' do
        transaction = current_merchant.transactions.new(status: params[:status],
                                                        amount: params[:amount])

        if transaction.save
          present(transaction, with: Api::Entities::Transaction)
        else
          status 422
          {
            status: :unprocessable_entity,
            errors: transaction.errors.messages
          }
        end
      end
    end
  end
end

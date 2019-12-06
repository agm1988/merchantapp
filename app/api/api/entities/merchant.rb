# frozen_string_literal: true

module Api
  module Entities
    class Merchant < Grape::Entity
      include Api::Entities::Common

      expose :id
      expose :name, documentation: { required: true }
      expose :description, documentation: { required: true }
      expose :email, documentation: { required: true }
      expose :status
      expose :total_transaction_sum
      expose :created_at
      expose :updated_at
      expose :transactions, with: ::Api::Entities::Transaction
    end
  end
end

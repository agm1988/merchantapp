# frozen_string_literal: true

module Api
  module Entities
    class Transaction < Grape::Entity
      include Api::Entities::Common

      expose :id
      expose :merchant_id
      expose :uuid
      expose :amount
      expose :status
      expose :reference_uuid
      expose :type
      expose :created_at
      expose :updated_at
    end
  end
end

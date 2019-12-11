# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Entities::Merchant do
  let(:expected_fields) do
    %i[id name description email status is_admin total_transaction_sum
       created_at updated_at transactions]
  end

  it_behaves_like 'entity'
end

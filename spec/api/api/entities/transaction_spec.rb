# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Entities::Transaction do
  let(:expected_fields) do
    %i[id merchant_id uuid amount status reference_uuid
       type created_at updated_at]
  end

  it_behaves_like 'entity'
end

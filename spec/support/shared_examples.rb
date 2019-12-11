# frozen_string_literal: true

RSpec.shared_examples 'unauthorized' do
  let(:errors) do
    { error: 'Unauthorized' }
  end
  specify { expect(response.json).to eq errors }
end

RSpec.shared_examples 'entity' do
  subject { described_class }

  it { is_expected.to expose(expected_fields) }
end

RSpec.shared_examples 'admin restricted area' do
  specify 'request restricted' do
    expect(last_response.status).to be 403
  end

  specify 'admin restricted message' do
    resp = JSON.parse(last_response.body)

    expect(resp['error']).to eq('Admin restricted')
  end
end

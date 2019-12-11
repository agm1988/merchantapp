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

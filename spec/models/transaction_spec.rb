# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  specify do
    expect(build(:transaction)).to be_valid
  end

  it 'associations' do
    expect(subject).to belong_to(:merchant)
    expect(subject).to belong_to(:reference).optional
    expect(subject).to have_one(:dependent)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:status) }
  end
end

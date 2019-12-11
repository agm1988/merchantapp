# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  specify 'has a valid factory' do
    expect(build(:merchant)).to be_valid
  end

  it 'associations' do
    expect(subject).to have_many(:transactions)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:status) }
  end

  specify 'uniqueness' do
    is_expected.to validate_uniqueness_of(:email).case_insensitive
  end
end

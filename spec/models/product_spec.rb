# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product do
  it 'has a valid factory' do
    expect(build(:product)).to be_valid
  end

  describe 'associations' do
    it 'belongs to sku' do
      expect(described_class.new).to belong_to(:sku)
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      expect(described_class.new).to validate_presence_of(:name)
    end
  end

  describe 'ransackable_attributes' do
    it 'returns an array with the attributes' do
      expect(described_class.ransackable_attributes).to eq(
        %w[created_at id id_value name price_in_cents sku_id updated_at]
      )
    end
  end

  describe 'ransackable_associations' do
    it 'returns an array with sku' do
      expect(described_class.ransackable_associations).to eq(['sku'])
    end
  end
end

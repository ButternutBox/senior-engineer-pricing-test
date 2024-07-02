# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Price do
  it 'has a valid factory' do
    expect(build(:price)).to be_valid
  end

  describe 'associations' do
    it 'has many products' do
      expect(described_class.new).to have_many(:product)
    end

    it 'has many order products' do
      expect(described_class.new).to have_many(:order_product)
    end
  end

  describe 'validations' do
    it 'validates presence of price_in_cents' do
      expect(described_class.new).to validate_presence_of(:price_in_cents)
    end
  end

  describe 'ransackable_attributes' do
    it 'returns an array with the attributes' do
      expect(described_class.ransackable_attributes).to eq(
        %w[created_at id id_value price_in_cents order_product_id product_id updated_at]
      )
    end
  end

  describe 'ransackable_associations' do
    it 'returns an array with sku' do
      expect(described_class.ransackable_associations).to eq(['order_product', 'product'])
    end
  end
end

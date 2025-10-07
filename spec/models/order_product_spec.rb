# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderProduct do
  it 'has a valid factory' do
    expect(build(:order_product)).to be_valid
  end

  describe 'associations' do
    it 'belongs to order' do
      expect(described_class.new).to belong_to(:order)
    end

    it 'belongs to product' do
      expect(described_class.new).to belong_to(:product)
    end
  end

  describe 'validations' do
    it 'validates presence of quantity' do
      expect(described_class.new).to validate_presence_of(:quantity)
    end
  end

  describe 'price snapshotting' do
    let(:product) { create(:product, price_in_cents: 100) }
    let(:order) { create(:order) }
    let(:order_product) { build(:order_product, order: order, product: product, quantity: 2) }

    it 'captures the price when order_product is saved' do
      order_product.save
      expect(order_product.price_snapshot_in_cents).to eq(100)
    end

    it 'does not change when product price changes' do
      order_product.save
      product.update(price_in_cents: 200)
      expect(order_product.reload.price_snapshot_in_cents).to eq(100)
    end
  end

  describe 'subtotal' do
    let(:product) { create(:product, price_in_cents: 100) }
    let(:order) { create(:order) }
    let(:order_product) { create(:order_product, order: order, product: product, quantity: 2) }

    it 'returns the subtotal using snapshot price' do
      expect(order_product.subtotal).to eq(200)
    end

    it 'uses snapshot price even when product price changes' do
      original_subtotal = order_product.subtotal
      product.update(price_in_cents: 500)
      expect(order_product.reload.subtotal).to eq(original_subtotal)
    end
  end

  describe 'ransackable_attributes' do
    it 'returns an array with the attributes' do
      expect(described_class.ransackable_attributes).to eq(%w[created_at id id_value order_id product_id quantity
                                                              updated_at])
    end
  end

  describe 'ransackable_associations' do
    it 'returns an empty array' do
      expect(described_class.ransackable_associations).to eq(%w[order product])
    end
  end
end

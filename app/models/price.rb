# frozen_string_literal: true

#
# Represents a price of a product at a point in time
#
class Price < ApplicationRecord
  has_many :product
  has_many :order_product

  validates :price_in_cents, presence: true

  # class methods
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value price_in_cents order_product_id product_id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[order_product product]
  end
end

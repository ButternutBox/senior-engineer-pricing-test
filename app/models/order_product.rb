# frozen_string_literal: true

#
# Represents a line item on the order
# Contains the quantity of the given product added to the order
#
class OrderProduct < ApplicationRecord
  # belongs to
  belongs_to :order
  belongs_to :product

  # validations
  validates :quantity, presence: true

  # callbacks
  before_save :capture_price_snapshot

  #
  # Calculates the subtotal for the given order product
  #
  # @return [Integer] the subtotal
  #
  def subtotal
    quantity * price_snapshot_in_cents
  end

  # class methods
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value order_id product_id quantity updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[order product]
  end

  private

  #
  # Captures the current price of the product at the time of order
  #
  def capture_price_snapshot
    self.price_snapshot_in_cents = product.price_in_cents
  end
end

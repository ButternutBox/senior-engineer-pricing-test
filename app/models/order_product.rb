# frozen_string_literal: true

#
# Represents a line item on the order
# Contains the quantity of the given product added to the order
#
class OrderProduct < ApplicationRecord
  # belongs to
  belongs_to :order
  belongs_to :price

  # validations
  validates :quantity, presence: true

  #
  # Calculates the subtotal for the given order product
  #
  # @return [Integer] the subtotal
  #
  def subtotal
    quantity * price.price_in_cents
  end

  # class methods
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value order_id product_id quantity updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[order product]
  end
end

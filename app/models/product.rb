# frozen_string_literal: true

#
# Represents a single product
#
class Product < ApplicationRecord
  # belongs to
  belongs_to :sku
  belongs_to :price

  # validations
  validates :name, presence: true

  # class methods
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value name price_in_cents sku_id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['sku']
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :order_product do
    order
    price
    quantity { 1 }
  end
end

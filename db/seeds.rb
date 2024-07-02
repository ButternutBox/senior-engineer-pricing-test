# frozen_string_literal: true
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
AdminUser.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password'
) if Rails.env.development?

sku = Sku.create!(product_code: 'SKU-001')

order = Order.create!(shipping_date: Date.today)

price = Price.create!(
  price_in_cents: 1000
)

product = Product.create!(
  name: 'Product 1',
  price:,
  sku:
)

order_product = OrderProduct.create!(
  order:,
  price:,
  quantity: 2
)


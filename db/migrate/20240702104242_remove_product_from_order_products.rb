class RemoveProductFromOrderProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :order_products, :product_id, :string
    add_reference :order_products, :price, null: false
  end
end

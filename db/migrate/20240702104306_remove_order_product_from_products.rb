class RemoveOrderProductFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :price_in_cents
    add_reference :products, :price, null: false
  end
end

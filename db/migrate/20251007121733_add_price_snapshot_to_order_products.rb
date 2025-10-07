class AddPriceSnapshotToOrderProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :order_products, :price_snapshot_in_cents, :integer
  end
end

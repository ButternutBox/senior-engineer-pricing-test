class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.integer :price_in_cents, null: false

      t.timestamps
    end
  end
end

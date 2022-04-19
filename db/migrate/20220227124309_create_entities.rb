class CreateEntities < ActiveRecord::Migration[6.1]
  def change
    create_table :entities do |t|

      t.integer :property_id, null: false
      t.integer :cart_id
      t.integer :reservation_id
      t.date :date, null: false
      t.decimal :price_ratio, default: 0
      t.integer :occupied_status, null: false, default: 1
      t.timestamps
    end
  end
end

class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|

      t.integer :user_id, null: false
      t.integer :property_id, null: false
      t.string :user_name, null: false
      t.integer :generation, null: false
      t.integer :sex, null: false
      t.string :address, null: false
      t.string :phone_number, null: false
      t.integer :total_price
      t.timestamps
    end
  end
end

class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|

      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :postal_code, null: false
      t.string :country, null: false
      t.integer :city, null: false, default: 0
      t.string :address, null: false
      t.string :introduction, null: false
      t.string :main_image
      t.json :sub_images
      t.boolean :if_dynamic_pricing, default: false
      t.integer :base_price, null: false
      t.integer :min_price
      t.integer :max_price
      t.integer :reservation_fee, default: 0
      t.integer :max_capacity, null: false
      t.timestamps
    end
  end
end

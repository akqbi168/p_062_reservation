class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|

      t.integer :user_id, null: false
      t.date :ci_date, null: false
      t.date :co_date, null: false
      t.timestamps
    end
  end
end

class CreateReputations < ActiveRecord::Migration[6.1]
  def change
    create_table :reputations do |t|

      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.decimal :rating, null: false
      t.string :testimonial
      t.boolean :visible, null: false, default: true
      t.timestamps
    end
  end
end

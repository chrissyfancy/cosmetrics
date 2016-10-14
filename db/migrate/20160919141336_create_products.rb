class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :brand
      t.text :description, default: "", null: false
      t.decimal :size
      t.decimal :price, precision: 8, scale: 2
      t.string :color
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string :product_photo, default: "/Users/christinafancy/challenges/online-review-site/sephora_reviews/db/migrate/placeholder.png", null: false
    end
  end
end

class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :body, null: false
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.belongs_to :product, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end

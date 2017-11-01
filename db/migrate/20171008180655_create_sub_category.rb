class CreateSubCategory < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_categories do |t|
      t.string :title, null: false
      t.string :description
      t.belongs_to :category
    end
  end
end

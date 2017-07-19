class AddCategoryToProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :product_type
    add_column :products, :category_id, :integer
  end
end

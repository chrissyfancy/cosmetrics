class AddProductValueToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :average_value, :decimal, default: 0.0
  end
end

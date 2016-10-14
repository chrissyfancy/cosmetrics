class AddPhotoToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :product_photo, :string, null: false, default: "#{Rails.root}/db/migrate/placeholder.png"
  end
end

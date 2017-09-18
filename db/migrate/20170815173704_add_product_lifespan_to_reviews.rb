class AddProductLifespanToReviews < ActiveRecord::Migration[5.0]
  def up
    add_column :reviews, :times_used_per_week, :integer
    add_column :reviews, :months_product_lasts, :integer

    Review.all.each do |review|
      review.times_used_per_week = rand(1..7)
      review.months_product_lasts = rand(1..18)
      review.save!
    end
  end

  def down
    remove_column :reviews, :times_used_per_week
    remove_column :reviews, :months_product_lasts
  end
end

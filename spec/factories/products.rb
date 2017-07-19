FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "Hoola Face Bronzer #{n}"}
    brand "Benefit Cosmetics"
    price 29.00
    description "Dust on Benefit's iconic hoola Matte Bronzer across the chin, cheeks, and forehead for a healthy, natural-looking tan year-round that flatters any skintone. Complete with soft, natural-bristle cheek brush, it delivers pure matte color—without leaving behind shine or shimmer."
    size 0.28
    color "Matte Finish"
    product_photo "/Users/christinafancy/challenges/online-review-site/sephora_reviews/db/migrate/placeholder.png"

    category
  end
end

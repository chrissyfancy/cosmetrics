FactoryGirl.define do
  factory :review do
    body "This is a test review from the review factory"
    rating 4
    user
    product
  end
end

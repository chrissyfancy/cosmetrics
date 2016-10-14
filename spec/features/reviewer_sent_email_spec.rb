require "rails_helper"

feature "review email" do
  scenario "review a product" do
    product = Product.first
    user = FactoryGirl.build(:user)
    product.id = 1

    visit new_product_review_path(product)

    fill_in "Review", with: "Great Product."
    click_button "Submit Review"

    expect(page).to have_content("Great Product.")
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end

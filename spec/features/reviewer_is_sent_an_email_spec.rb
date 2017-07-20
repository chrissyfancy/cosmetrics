require "rails_helper"

feature "A user recieves an email", pending: true do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:product) { FactoryGirl.create(:product)}

  scenario "an authenticated user succesfully reviews a product" do
    visit root_path
    login_as user
    visit new_product_review_path(product.id)

    fill_in "Review", with: "The BEST EVER!!!"
    select 1, from: "Rating"

    click_button "Submit Review"

    expect(page).to have_content("The BEST EVER!!!")
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end

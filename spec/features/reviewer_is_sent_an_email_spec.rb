require "rails_helper"

feature "An authenticated user recieves an email", pending: true do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:product) { FactoryGirl.create(:product)}

  scenario "after succesfully reviewing a product" do
    visit root_path
    login_as user
    click_link "BENEFIT COSMETICS"

    fill_in "review_body", with: "The BEST EVER!!!"
    choose 5
    click_button "Submit Review"

    expect(page).to have_content("The BEST EVER!!!")
    expect(page).to have_content("Thank you. Your review has been saved.")
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end

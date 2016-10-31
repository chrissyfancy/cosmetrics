require 'rails_helper'

feature "admin adds a new product" do

  let(:user) { FactoryGirl.create(:user, role: 'admin') }

  scenario 'add a product', focus: true do
    login_as(user)
    visit new_product_path

    fill_in 'Name', with: "Hoola Matte Bronzer"
    fill_in 'Brand', with: "Benefit Cosmetics"
    fill_in 'Description', with: "Dust on Benefit's iconic hoola Matte Bronzer across the chin, cheeks, and forehead for a healthy, natural-looking tan year-round that flatters any skintone. Complete with soft, natural-bristle cheek brush, it delivers pure matte color—without leaving behind shine or shimmer."
    fill_in 'Price', with: 29.00
    fill_in 'Size', with: 0.28
    fill_in 'Type of Product', with: 'Bronzer'
    fill_in 'Photo URL', with: "/Users/christinafancy/challenges/online-review-site/sephora_reviews/db/migrate/placeholder.png"
    click_on 'Submit Product'

    expect(page).to have_content('Successfully added product.')
    expect(page).to have_content('Hoola Matte Bronzer')
  end

end
require 'rails_helper'

feature "an authorized admin" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let!(:category) { FactoryGirl.create(:category) }

  scenario 'successfully adds a new product when data is valid' do
    login_as(admin)
    visit new_product_path

    fill_in 'Name', with: "Hoola Matte Bronzer"
    fill_in 'Brand', with: "Benefit Cosmetics"
    fill_in 'Description', with: "Dust on Benefit's iconic hoola Matte Bronzer across the chin, cheeks, and forehead for a healthy, natural-looking tan year-round that flatters any skintone. Complete with soft, natural-bristle cheek brush, it delivers pure matte color—without leaving behind shine or shimmer."
    fill_in 'Price', with: 29.00
    fill_in 'Size', with: 0.28
    select category.name, from: 'Category'
    fill_in 'Photo URL', with: "/Users/christinafancy/challenges/online-review-site/sephora_reviews/db/migrate/placeholder.png"
    click_on 'Submit Product'

    expect(page).to have_content('Successfully added product.')
    expect(page).to have_content("Hoola Matte Bronzer")
    expect(page).to have_content("BENEFIT COSMETICS")
  end

  scenario 'unsuccessfully adds a new product when data is invalid' do
    login_as(admin)
    visit new_product_path

    fill_in 'Name', with: ""
    fill_in 'Brand', with: ""
    fill_in 'Description', with: ""
    fill_in 'Price', with: ""
    fill_in 'Size', with: ""
    select category.name, from: 'Category'
    fill_in 'Photo URL', with: ""
    click_on 'Submit Product'

    expect(page).to have_content("2 errors prohibited this product from being saved:")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Brand can't be blank")
  end

end

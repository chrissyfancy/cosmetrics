require 'rails_helper'

feature "an authorized admin" do
  let!(:admin) { FactoryGirl.create(:user, role: 'admin') }

  scenario 'successfully adds a new category when information is valid' do
    login_as(admin)
    visit new_category_path

    fill_in 'Name', with: "Skin Care"
    fill_in 'Description', with: ""
    click_on 'Submit Category'

    expect(page).to have_content('Successfully added category.')
    expect(page).to have_content("Skin Care")
  end

  scenario 'unsuccessfully adds a new category when information is not valid' do
    login_as(admin)
    visit new_category_path

    fill_in 'Name', with: ''
    fill_in 'Description', with: ''
    click_on 'Submit Category'

    expect(page).to have_content("1 error prohibited this category from being saved")
    expect(page).to have_content("Name can't be blank")
  end
end

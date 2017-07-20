require 'rails_helper'

feature "an authorized admin" do
  let!(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let!(:category) { FactoryGirl.create(:category) }

  scenario 'successfully adds a new category' do
    login_as(admin)
    visit new_category_path

    fill_in 'Name', with: category.name
    fill_in 'Description', with: category.description
    click_on 'Submit Category'

    expect(page).to have_content('Successfully added category.')
    expect(page).to have_content(category.name)
  end
end

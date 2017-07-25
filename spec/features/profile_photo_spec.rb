require "rails_helper"

feature "profile photo" do
  scenario "user uploads a profile photo" do
    visit root_path
    click_link "Register"

    fill_in "First Name", with: "Jon"
    fill_in "Last Name", with: "Smith"
    fill_in "Email", with: "ash@s-mart.com"
    fill_in "Password", with: "boomstick!3vilisd3ad"
    fill_in "Password Confirmation", with: "boomstick!3vilisd3ad"
    attach_file "Profile Picture", "#{Rails.root}/spec/support/images/photo.png"
    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
  end
end

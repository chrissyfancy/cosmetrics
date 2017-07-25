require 'spec_helper'
require 'rails_helper'

feature 'A new user signs up' do
  scenario 'user sees all of the expected sign up fields' do
    visit root_path
    click_link 'Register'
    expect(page).to have_content('First Name')
    expect(page).to have_content('Last Name')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password (6 characters minimum)')
    expect(page).to have_content('Password Confirmation')
    expect(page).to have_content('Profile Picture')
  end

  scenario 'user specifies valid and required information' do
    visit root_path
    click_link 'Register'

    fill_in 'First Name', with: 'Arya'
    fill_in 'Last Name', with: 'Stark'
    fill_in 'Email', with: 'arya@winterfell.com'
    fill_in 'Password', with: 'HouseStark4Ever'
    fill_in 'Password Confirmation', with: 'HouseStark4Ever'
    click_button 'Sign up'

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Your Account")
  end

  scenario 'required information is not supplied' do
    visit root_path
    click_link 'Register'
    click_button 'Sign up'

    expect(page).to have_content("4 errors prohibited this user from being saved:")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end

require "rails_helper"

feature 'admin can see a list of users' do
  let(:admin) { FactoryGirl.build(:user, role: 'admin') }
  let!(:user) { FactoryGirl.build(:user) }

  scenario 'admin visits users index' do
    login_as(admin)
    visit '/admin/users'

    expect(page).to have_content(admin.email)
  end

  scenario 'unauthorized users are redirected' do
    login_as(user)
    visit '/admin/users'

    expect(page).to have_content('not authorized')
    expect(current_path).to eq(root_path)
  end
end

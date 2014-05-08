require 'spec_helper'

feature 'Deleting users' do
  let!(:admin) { create(:admin_user) }
  let!(:user) { create(:user) }

  before do
    sign_in_as!(admin)
    visit('/')
    click_link 'Admin'
    click_link 'Users'
  end

  scenario 'Deleting a user' do
    click_link user.email
    click_link "Delete User"

    expect(page).to have_content("User has been deleted")
  end

  scenario 'User cannot delete themselves' do
    click_link admin.email
    click_link "Delete User"

    expect(page).to have_content("You cannot delete yourself")
  end
end

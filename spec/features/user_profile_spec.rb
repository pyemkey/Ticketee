require 'spec_helper'

feature 'Profile page' do
  let(:user) { create(:user) }

  scenario 'viewing' do
    sign_in_as!(user)
    visit user_path(user)
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.email)
  end

  scenario 'Editing Users' do

    sign_in_as!(user)
    visit user_path(user)
    click_link("Edit Profile")

    fill_in "Username", with: "new username"
    click_button "Update Profile"

    expect(page).to have_content("Profile has been updated.")
  end
end

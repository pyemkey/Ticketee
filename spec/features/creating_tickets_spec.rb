require 'spec_helper'

feature "Creating Tickets" do
  let!(:project) { create(:project, name: "Internet Explorer") }
  let!(:user) { create(:user) }

  before do
    define_permission!(user, "view", project)
    visit '/'
    click_link project.name
    message = "You need to sign in or sign up before continuing."
    expect(page).to have_content(message)

    sign_in_as!(user)
    click_link project.name
    click_link "New Ticket"
  end

  scenario 'Creating a ticket' do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")
    within "#ticket #author" do
      expect(page).to have_content("Created by #{user.email}")
    end
  end

  scenario 'Creating a ticket without valid attributes fails' do
    click_button "Create Ticket"

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Ticket has not been created.")
  end

  scenario 'Description must be longer than 10 charactes' do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "it sucks"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Description is too short")
  end
end

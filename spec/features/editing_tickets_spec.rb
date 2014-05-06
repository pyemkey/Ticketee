require 'spec_helper'

feature "Editing tickets" do
  let!(:project) { create(:project) }
  let(:user) { create(:user) }
  let!(:ticket) { create(:ticket, project: project, user: user) }

  before do
    sign_in_as!(user)

    visit '/'

    click_link project.name
    click_link ticket.title
    click_link "Edit Ticket"
  end

  scenario "Updating a ticket" do
    fill_in "Title", with: "Make it really shiny!"
    click_button "Update Ticket"

    expect(page).to have_content "Ticket has been updated."

    within("#ticket h2") do
      expect(page).to have_content("Make it really shiny!")
    end

    expect(page).to_not have_content ticket.title
  end
end

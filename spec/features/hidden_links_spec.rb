require 'spec_helper'

feature 'hidden links' do
  let(:user) { create(:user) }
  let(:admin) { create(:admin_user) }
  let(:project) { create(:project) }
  let(:ticket) { create(:ticket, project: project, user: user) }

  context "anonmous users" do
    scenario "cannot see the New Project link" do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
  end

  context "regular users" do
    before { sign_in_as!(user) }
    scenario 'cannot see the New Project link' do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario 'cannot see the Edit Project link' do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario 'cannot see the Delete Project link' do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end

    scenario 'New ticket link is hidden from a user without permission' do
      visit project_path(project)
      assert_no_link_for "New Project"
    end

    scenario 'Edit ticket link is shown to a user with permission' do
      #this scenario needs the ticket created first to set correct permissions
      ticket
      define_permission!(user, 'view', project)
      define_permission!(user, 'edit tickets', project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end

    scenario 'Edit ticket link is hidden from a user without permission' do
      ticket
      define_permission!(user, 'view', project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for 'Edit Ticket'
    end

    scenario 'Delete ticket link is shown to a user with permission' do
      ticket
      define_permission!(user, 'view', project)
      define_permission!(user, 'delete tickets', project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for 'Delete Ticket'
    end

    scenario 'Delete ticket link is hidden from a users without permission' do
      ticket
      define_permission!(user, 'view', project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for 'Delete Ticket'
    end
  end

  context "admin users" do
    before { sign_in_as!(admin) }
    scenario "can see the New Project link" do
      visit '/'
      assert_link_for "New Project"
    end

    scenario "can see the Edit Project link" do
      visit project_path(project)
      assert_link_for "Delete Project"
    end

    scenario "can see the Delete Project link" do
      visit project_path(project)
      assert_link_for "Delete Project"
    end

    scenario "New ticket is shown to admins" do
      visit project_path(project)
      assert_link_for "New Ticket"
    end

    scenario "Edit ticket link is shown to admins" do
      ticket
      visit project_path(project)
      click_link ticket.title
      assert_link_for 'Edit Ticket'
    end

    scenario 'Delete ticket link is shown to admins' do
      ticket
      visit project_path(project)
      click_link ticket.title
      assert_link_for 'Delete Ticket'
    end
  end
end

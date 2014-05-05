require 'spec_helper'

feature "Viewing projects" do
  scenario "Listing all projects" do
    project = create(:project, name: "TextMate 2")
    visit '/'
    click_link 'TextMate 2'
    expect(page.current_url).to eql(project_url(project)) 
  end
end

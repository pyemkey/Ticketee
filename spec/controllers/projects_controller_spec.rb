require 'spec_helper'

describe ProjectsController do
  it 'displays and error for a missing project' do
    get :show, id: 'not-here'
    expect(response).to redirect_to(projects_path)
    message = "The project you were looking for could not be found."
    expect(flash[:danger]).to eql(message)
  end
end
require 'spec_helper'

describe TicketsController do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:ticket) { create(:ticket,
                         user: user,
                         project: project) }

  context 'standard users' do
    it 'cannot access ticket for a project' do
      sign_in(user)
      get :show, id: ticket.id, project_id: project.id

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql("The project you were looking for could not be found.")
    end
  end
end

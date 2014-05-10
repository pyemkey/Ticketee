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

  context 'with permission to view project' do
    before do
      sign_in(user)
      define_permission!(user, 'view', project)
    end

    def cannot_create_tickets!
      expect(response).to redirect_to(project)
      message = "You cannot create tickets on this project."
      expect(flash[:danger]).to eq(message)
    end

    def cannot_update_tickets!
      expect(response).to redirect_to(project)
      expect(flash[:danger]).to eq("You cannot edit tickets on this project.") 
    end
    
    def cannot_delete_tickets!
      expect(response).to redirect_to(project)
      expect(flash[:danger]).to eq("You cannot delete tickets on this project.") 
    end

    it 'cannot begin to create ticket' do
      get :new, project_id: project.id
      cannot_create_tickets!
    end

    it 'cannot create a ticket without permission' do
      post :create, project_id: project.id
      cannot_create_tickets!
    end

    it 'cannot begin to edit ticket' do
      get :edit, { project_id: project.id, id: ticket.id }
      cannot_update_tickets!
    end

    it 'cannot update a ticket without permission' do
      put :update, { project_id: project.id, id: ticket.id, ticket: {} }
      cannot_update_tickets!
    end

    it "cannot delete a ticket without permission" do
      delete :destroy, { project_id: project.id, id: ticket.id }
      cannot_delete_tickets! 
    end
  end
end

require 'spec_helper'

describe Admin::UsersController do
  let(:user) { create(:user) }

  context 'standard users' do
    before { sign_in(user) }

    it 'are not able to access the index action' do
      get 'index'

      expect(response).to redirect_to('/')
      expect(flash[:danger]).to eql("You must be an admin to do that.")
    end
  end
end

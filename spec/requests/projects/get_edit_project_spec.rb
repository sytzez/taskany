# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /projects/:id/edit' do
  let(:project) { create(:project) }

  context 'when signed in' do
    before { sign_in create :user }

    it 'renders a successful response' do
      get edit_project_url(project)
      expect(response).to be_successful
    end

    context 'when the project does not exist' do
      it 'returns a not found error' do
        expect { edit_project_url(-1) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'when not signed in' do
    it 'redirects to the sign in page' do
      get edit_project_url(project)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

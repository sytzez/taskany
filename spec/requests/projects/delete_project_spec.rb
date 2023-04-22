# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /projects/:id' do
  let!(:project) { create(:project) }

  context 'when signed in' do
    before { sign_in create :user }

    it 'destroys the requested project' do
      expect do
        delete project_url(project)
      end.to change(Project, :count).by(-1)
    end

    it 'redirects to the projects list' do
      delete project_url(project)
      expect(response).to redirect_to(projects_url)
    end

    context 'when the project does not exist' do
      it 'returns a not found error' do
        expect { delete project_url(-1) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'when not signed in' do
    it 'redirects to the sign in page' do
      delete project_url(project)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

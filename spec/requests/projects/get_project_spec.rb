# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /projects/:id' do
  let(:project) { create(:project) }

  context 'when signed in' do
    before { sign_in create :user }

    it 'redirects to the tasks index' do
      get project_url(project)
      expect(response).to redirect_to project_tasks_url(project)
    end

    context 'when the project does not exists' do
      it 'returns a not found error' do
        expect { get project_url(-1) }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  context 'when not signed in' do
    it 'redirects to the sign in page' do
      get project_url(project)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

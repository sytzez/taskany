# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET projects/:project_id/tasks' do
  let(:project) { create(:project_with_tasks) }

  context 'when signed in' do
    before { sign_in create(:user) }

    it 'returns a successful response' do
      get project_tasks_url(project)
      expect(response).to be_successful
    end

    context 'when the project has no tasks' do
      before { project.tasks.destroy_all }

      it 'returns a successful response' do
        get project_tasks_url(project)
        expect(response).to be_successful
      end
    end

    context 'when the project does not exists' do
      it 'returns a not found error' do
        expect { get project_tasks_url(-1) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'when not signed in' do
    it 'redirects to the sign in page' do
      get project_tasks_url(project)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

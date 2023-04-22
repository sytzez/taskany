# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET projects/:project_id/tasks/new' do
  let(:project) { create(:project) }

  context 'when signed in' do
    before { sign_in create(:user) }

    it 'returns a successful response' do
      get new_project_task_url(project)
      expect(response).to be_successful
    end

    context 'when the project does not exist' do
      it 'returns a not found error' do
        expect { get new_project_task_url(-1) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'when not signed in' do
    it 'redirects to the sign in page' do
      get new_project_task_url(project)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

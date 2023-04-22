# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE projects/:project_id/tasks/:id' do
  let(:project) { create(:project_with_tasks) }

  let!(:task) { project.tasks.first }

  context 'when signed in' do
    before { sign_in create(:user) }

    it 'destroys the requested task' do
      expect do
        delete project_task_url(project, task)
      end.to change(project.tasks, :count).by(-1)
    end

    it 'redirects to the tasks list' do
      delete project_task_url(project, task)
      expect(response).to redirect_to(project_tasks_url(project))
    end

    context 'when the task does not exist' do
      it 'returns a not found error' do
        expect { delete project_task_url(project, -1) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when the task is not in the project' do
      it 'returns a not found error' do
        other_project = create(:project)
        expect { delete project_task_url(other_project, task) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'when not signed in' do
    it 'redirects to the sign in page' do
      delete project_task_url(project, task)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

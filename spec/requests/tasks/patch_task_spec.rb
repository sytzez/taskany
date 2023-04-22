# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PATCH projects/:project_id/tasks/:id' do
  let(:user) { create(:user) }

  let(:project) { create(:project_with_tasks) }

  let(:task) { project.tasks.first }

  let(:valid_attributes) do
    {
      assigned_user_id: user.id,
      title: 'A title',
      description: 'A description',
      story_points: 1,
      status: 'on_hold'
    }
  end

  let(:invalid_attributes) do
    {
      assigned_user_id: 0,
      title: '',
      description: '',
      story_points: 0,
      status: ''
    }
  end

  context 'when signed in' do
    before { sign_in user }

    it 'updates the task' do
      patch project_task_url(project, task), params: { task: valid_attributes }

      expect(task.reload).to have_attributes(assigned_user: user, title: 'A title', description: 'A description',
                                             story_points: 1, status: 'on_hold')
    end

    it 'redirects to the task' do
      patch project_task_url(project, task), params: { task: valid_attributes }
      expect(response).to redirect_to(project_task_url(project, task))
    end

    context 'when the task is not in the project', :realistic_error_responses do
      it 'renders a response with 404 status' do
        other_project = create(:project)
        patch project_task_url(other_project, task), params: { task: valid_attributes }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with invalid parameters' do
      it 'renders a response with 422 status' do
        patch project_task_url(project, task), params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'when not signed in' do
    it 'redirects to the sign in page' do
      patch project_task_url(project, task), params: { task: valid_attributes }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

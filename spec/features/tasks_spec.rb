# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks' do
  before { sign_in create :user }

  let!(:project) { create(:project) }
  let!(:user) { create(:user) }

  context 'when using the new task form' do
    before do
      visit project_path(project)
      click_link 'New task'

      select user.email, from: 'task[assigned_user_id]'
      fill_in 'task[title]', with: 'New Task'
      fill_in 'task[description]', with: 'About this task'
      fill_in 'task[story_points]', with: 3
      select 'In progress', from: 'task[status]'
    end

    it 'creates a new task' do
      expect do
        click_button 'Create Task'
        project.reload
      end.to change(project.tasks, :count).by 1
    end

    it 'gives the task the right values' do
      click_button 'Create Task'
      expect(project.tasks.last).to have_attributes(assigned_user: user, title: 'New Task',
                                                    description: 'About this task', story_points: 3,
                                                    in_progress?: true)
    end
  end

  context 'when using the edit task form' do
    let(:task) { create(:task) }

    before do
      visit project_path(task.project)
      within(".task#task_#{task.id}") do
        click_link '✏'
      end

      select user.email, from: 'task[assigned_user_id]'
      fill_in 'task[title]', with: 'New Task'
      fill_in 'task[description]', with: 'About this task'
      fill_in 'task[story_points]', with: 3
      select 'In progress', from: 'task[status]'
    end

    it 'updates the task' do
      click_button 'Update Task'
      expect(task.reload).to have_attributes(assigned_user: user, title: 'New Task',
                                             description: 'About this task', story_points: 3,
                                             in_progress?: true)
    end
  end
end

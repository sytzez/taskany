# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks' do
  before { sign_in create :user }

  let!(:project) { create(:project) }
  let!(:user) { create(:user) }

  it 'creates a new task' do
    visit project_path(project)
    click_link 'New task'

    select user.email, from: 'task[assigned_user_id]'
    fill_in 'task[title]', with: 'New Task'
    fill_in 'task[description]', with: 'About this task'
    fill_in 'task[story_points]', with: 3
    select 'In progress', from: 'task[status]'

    expect do
      click_button 'Create Task'
      project.reload
    end.to change(project.tasks, :count).by 1

    task = project.tasks.last
    expect(task.assigned_user).to eq user
    expect(task.title).to eq 'New Task'
    expect(task.description).to eq 'About this task'
    expect(task.story_points).to eq 3
    expect(task).to be_in_progress
  end

  context 'a task exists' do
    let!(:task) { create(:task) }

    it 'edits a task' do
      visit project_path(task.project)
      within(".task#task_#{task.id}") do
        click_link '✏'
      end

      select user.email, from: 'task[assigned_user_id]'
      fill_in 'task[title]', with: 'New Task'
      fill_in 'task[description]', with: 'About this task'
      fill_in 'task[story_points]', with: 3
      select 'In progress', from: 'task[status]'

      click_button 'Update Task'
      task.reload

      expect(task.assigned_user).to eq user
      expect(task.title).to eq 'New Task'
      expect(task.description).to eq 'About this task'
      expect(task.story_points).to eq 3
      expect(task).to be_in_progress
    end
  end
end

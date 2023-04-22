# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Projects' do
  before { sign_in create :user }

  context 'when using the new project form' do
    before do
      visit projects_path
      click_link 'New project'

      fill_in 'project[title]', with: 'New Project'
    end

    it 'creates a new project' do
      expect do
        click_button 'Create Project'
      end.to change(Project, :count).by 1
    end

    it 'gives the new project the right title' do
      click_button 'Create Project'
      expect(Project.last.title).to eq 'New Project'
    end
  end

  context 'when using the edit project form' do
    let(:project) { create(:project) }

    before do
      visit project_path(project)
      click_link 'Edit project'

      fill_in 'project[title]', with: 'New Title'
    end

    it 'updates the project' do
      expect do
        click_button 'Update Project'
        project.reload
      end.to change(project, :title).to 'New Title'
    end
  end
end

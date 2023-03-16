# frozen_string_literal: true

require "rails_helper"

RSpec.describe 'Projects', type: :feature do
  before do
    sign_in create :user
  end

  it 'creates a new project' do
    visit projects_path
    click_link 'New project'

    fill_in 'project[title]', with: 'New Project'

    expect {
      click_button 'Create Project'
    }.to change(Project, :count).by 1

    expect(Project.last.title).to eq 'New Project'
  end

  context 'a project exists' do
    let!(:project) { create :project }

    it 'edits a project' do
      visit project_path(project)
      click_link 'Edit project'

      fill_in 'project[title]', with: 'New Title'

      expect {
        click_button 'Update Project'
        project.reload
      }.to change(project, :title).to 'New Title'
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe 'Board live updates', type: :feature do
  before { sign_in create :user }

  let(:project) { create :project }

  it 'updates when a new task has been added', js: true do
    visit project_path(project)

    task = build :task
    task.project = project
    task.save!

    find("#task_#{task.id}")

    assert_selector '.task p', text: task.title
  end
end

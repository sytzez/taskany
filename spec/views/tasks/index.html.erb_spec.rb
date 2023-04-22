# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks/index' do
  let(:project) { create(:project_with_tasks) }
  let(:tasks) { project.tasks }

  before do
    assign(:tasks, tasks)
    assign(:project, project)
  end

  it 'renders a list of tasks' do
    render
    assert_select 'p', text: Regexp.new(tasks[0].title)
    assert_select 'p', text: Regexp.new(tasks[1].title)
  end
end

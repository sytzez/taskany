require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  let(:project) { create :project }
  let(:task) { project.tasks.build }

  before(:each) do
    assign(:task, task)
    assign(:project, project)
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", project_tasks_path(project), "post" do

      assert_select "input[name=?]", "task[title]"

      assert_select "textarea[name=?]", "task[description]"

      assert_select "input[name=?]", "task[story_points]"

      assert_select "select[name=?]", "task[status]"
    end
  end
end

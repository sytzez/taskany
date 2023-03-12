require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  let(:task) { create :task }
  let(:project) { task.project }

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
    end
  end
end

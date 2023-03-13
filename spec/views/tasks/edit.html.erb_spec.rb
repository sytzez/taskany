require 'rails_helper'

RSpec.describe "tasks/edit", type: :view do
  let(:task) { create :task }
  let(:project) { task.project }

  before(:each) do
    assign(:task, task)
    assign(:project, project)
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", project_task_path(project, task), "post" do

      assert_select "input[name=?]", "task[title]"

      assert_select "textarea[name=?]", "task[description]"

      assert_select "input[name=?]", "task[story_points]"

      assert_select "select[name=?]", "task[status]"
    end
  end
end

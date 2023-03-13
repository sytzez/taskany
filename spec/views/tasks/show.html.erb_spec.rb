require 'rails_helper'

RSpec.describe "tasks/show", type: :view do
  let(:task) { create :task }
  let(:project) { task.project }

  before(:each) do
    assign(:task, task)
    assign(:project, project)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(Regexp.new(task.title))
    expect(rendered).to match(Regexp.new(task.story_points.to_s))
    expect(rendered).to match(Regexp.new(task.assigned_user.email))
  end
end

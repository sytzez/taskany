# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'projects/edit' do
  let(:project) do
    Project.create!(
      title: 'MyString'
    )
  end

  before do
    assign(:project, project)
    render
  end

  it 'renders the edit project form' do
    assert_select 'form[action=?][method=?]', project_path(project), 'post' do
      assert_select 'input[name=?]', 'project[title]'
    end
  end
end

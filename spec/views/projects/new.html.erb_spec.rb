# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'projects/new' do
  before do
    assign(:project, Project.new(
                       title: 'MyString'
                     ))
    render
  end

  it 'renders new project form' do
    assert_select 'form[action=?][method=?]', projects_path, 'post' do
      assert_select 'input[name=?]', 'project[title]'
    end
  end
end

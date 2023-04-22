# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'projects/index' do
  before do
    assign(:projects, [
             Project.create!(
               title: 'Title'
             ),
             Project.create!(
               title: 'Title'
             )
           ])
  end

  it 'renders a list of projects' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Title'.to_s), count: 2
  end
end

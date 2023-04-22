# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardComponent, type: :component do
  before { render_inline described_class.new(tasks: project.tasks) }

  context 'when the project is empty' do
    let(:project) { create(:project) }

    it 'renders a column for each task state' do
      expect(page).to have_css '.board .column', count: 8
    end

    it 'renders no tasks' do
      expect(page).not_to have_css '.task'
    end
  end

  context 'when the project has tasks' do
    let(:project) { create(:project_with_tasks) }

    it 'renders a column for each task state' do
      expect(page).to have_css '.board .column', count: 8
    end

    it 'renders each task exactly once' do
      expect(page).to have_css '.task', count: project.tasks.count
    end
  end
end

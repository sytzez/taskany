# frozen_string_literal: true

require "rails_helper"

RSpec.describe ColumnComponent, type: :component do
  subject { described_class.new(title: title, tasks: tasks) }

  let(:title) { "In progress" }

  before { render_inline subject }

  context "when no tasks are given" do
    let(:tasks) { [] }

    it "renders the title" do
      expect(page).to have_text "In progress"
    end

    it "renders a column" do
      expect(page).to have_css ".column", count: 1
    end

    it "renders no tasks" do
      expect(page).not_to have_css ".task"
    end
  end

  context "when tasks are given" do
    let(:task_count) { 0 }
    let(:tasks) { Array.new(task_count) { create :task } }

    it "renders the title" do
      expect(page).to have_text "In progress"
    end

    it "renders a column" do
      expect(page).to have_css ".column", count: 1
    end

    it "renders all tasks once" do
      expect(page).to have_css ".task", count: task_count
    end
  end
end

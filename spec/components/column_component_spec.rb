# frozen_string_literal: true

require "rails_helper"

RSpec.describe ColumnComponent, type: :component do
  describe "rendered result" do
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

  describe "#for_all_statuses" do
    subject { described_class.for_all_statuses(tasks: tasks) }

    context "when no tasks are given" do
      let(:tasks) { [] }

      it "returns a column component for each task state" do
        expect(subject.count).to eq 8
      end

      it "returns empty column components" do
        rendered_results = subject.map { |column| render_inline column }

        rendered_results.each do |rendered_result|
          expect(rendered_result).not_to have_css ".task"
        end
      end
    end

    context "when there are tasks" do
      let(:tasks) do
        [
          create(:task, :unstarted),
          create(:task, :unstarted),
          create(:task, :unstarted),
          create(:task, :in_progress),
          create(:task, :in_progress),
          create(:task, :client_review),
        ]
      end

      it "returns a column component for each task state" do
        expect(subject.count).to eq 8
      end

      it "puts the tasks in the right columns" do
        rendered_results = subject.map { |column| render_inline column }

        [3, 0, 2, 0, 0, 1, 0, 0].each_with_index do |expected_tasks_count, i|
          expect(rendered_results[i]).to have_css ".task", count: expected_tasks_count
        end
      end
    end
  end
end
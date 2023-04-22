# frozen_string_literal: true

class ColumnComponent < ViewComponent::Base
  def initialize(title:, tasks:)
    @title = title
    @tasks = tasks
    @story_points = tasks.sum(&:story_points)
  end

  # Get an enumerable of columns, one for each status
  def self.for_all_statuses(tasks:)
    Task.statuses.keys.map do |status|
      new(
        title: status.humanize,
        tasks: tasks.filter { |t| t.status == status }
      )
    end
  end
end

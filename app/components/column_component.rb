# frozen_string_literal: true

class ColumnComponent < ViewComponent::Base
  def initialize(title:, status:, tasks:)
    @title = title
    @status = status
    @tasks = tasks.filter { |t| t.status == status }
    @story_points = @tasks.sum { |t| t.story_points }
  end

  # Get an enumerable of columns, one for each status
  def self.for_all_statuses(tasks:)
    Task.statuses.keys.map do |status|
      new(
        title: status.humanize,
        status: status,
        tasks: tasks,
      )
    end
  end
end

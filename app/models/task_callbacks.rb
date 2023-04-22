# frozen_string_literal: true

class TaskCallbacks
  def self.after_commit(task)
    is_newly_created = task.saved_change_to_id?

    if task.saved_change_to_status? || task.saved_change_to_story_points? || is_newly_created
      board_component = BoardComponent.new(tasks: task.project.tasks)

      task.broadcast_update_to "project_tasks_#{task.project.id}",
                               html: ApplicationController.render(board_component),
                               target: 'board'
    else
      task.broadcast_update_to "project_tasks_#{task.project.id}",
                               partial: 'tasks/task',
                               locals: { task: },
                               target: "task_#{task.id}"
    end
  end
end

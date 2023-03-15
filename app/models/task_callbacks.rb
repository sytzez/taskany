class TaskCallbacks
  def self.after_commit(task)
    if task.saved_change_to_status?
      board_component = BoardComponent.new(tasks: task.project.tasks)

      task.broadcast_update_to "project_tasks_#{task.project.id}",
                               html: ApplicationController.render(board_component),
                               target: "board"
    else
      task.broadcast_update_to "project_tasks_#{task.project.id}",
                               partial: "tasks/task",
                               locals: { task: task },
                               target: "task_#{task.id}"
    end
  end
end

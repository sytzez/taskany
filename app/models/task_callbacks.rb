class TaskCallbacks
  def self.after_commit(task)
    if task.saved_change_to_status?
      task.broadcast_update_to "project_tasks_#{task.project.id}",
                               partial: BoardComponent.new(tasks: task.project.tasks),
                               target: "board"
    else
      task.broadcast_update_to "project_tasks_#{task.project.id}",
                               partial: "tasks/task",
                               locals: { task: task },
                               target: "task_#{task.id}"
    end
  end
end

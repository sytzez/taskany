# frozen_string_literal: true

class TaskCallbacks
  def self.after_commit(task)
    is_newly_created = task.saved_change_to_id?

    if task.saved_change_to_status? || task.saved_change_to_story_points? || is_newly_created
      task.broadcast_board_update
    else
      task.broadcast_task_update
    end
  end
end

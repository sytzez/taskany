json.extract! task, :id, :project_id, :user_id, :title, :description, :story_points, :created_at, :updated_at
json.url task_url(task, format: :json)

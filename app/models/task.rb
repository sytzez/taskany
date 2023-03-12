class Task < ApplicationRecord
  belongs_to :project
  belongs_to :assigned_user, class_name: 'User'

  validates :title, :description, :story_points, presence: true
  validates :story_points, numericality: { greater_than_or_equal_to: 0 }
end

# == Schema Information
#
# Table name: tasks
#
#  id               :integer          not null, primary key
#  project_id       :integer          not null
#  assigned_user_id :integer          not null
#  title            :string
#  description      :text
#  story_points     :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :project
  belongs_to :assigned_user, class_name: 'User'

  validates :title, :description, :story_points, presence: true
  validates :story_points, numericality: { greater_than_or_equal_to: 0 }
end

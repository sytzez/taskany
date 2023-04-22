# frozen_string_literal: true

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
  # Enums
  enum status: {
    unstarted: 0,
    on_hold: 1,
    in_progress: 2,
    code_review: 3,
    internal_review: 4,
    client_review: 5,
    ready_for_live: 6,
    done: 7
  }

  # Associations
  belongs_to :project
  belongs_to :assigned_user, class_name: 'User'

  # Validations
  validates :title, :description, :story_points, :status, presence: true
  validates :story_points, numericality: { greater_than_or_equal_to: 0 }

  # Callbacks
  after_commit TaskCallbacks
end

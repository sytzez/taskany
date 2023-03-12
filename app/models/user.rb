class User < ApplicationRecord
  has_many :tasks, foreign_key: :assigned_user_id, class_name: 'Task'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

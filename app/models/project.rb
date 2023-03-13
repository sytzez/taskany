# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Project < ApplicationRecord
  # Associations
  has_many :tasks, dependent: :destroy

  # Validations
  validates :title, presence: true
end

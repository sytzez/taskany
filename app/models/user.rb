# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Associations
  has_many :tasks,
           foreign_key: :assigned_user_id,
           class_name: 'Task',
           dependent: :destroy,
           inverse_of: :assigned_user

  # Macros
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

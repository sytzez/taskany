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
FactoryBot.define do
  factory :task do
    project
    assigned_user factory: :user
    title { generate :task_title }
    description { "Lorem ipsum" }
    story_points { 1 }
    traits_for_enum :status
  end

  sequence(:task_title) { |n| "Task #{n}" }
end

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
    project { nil }
    user { nil }
    title { "MyString" }
    description { "MyText" }
    story_points { 1 }
  end
end

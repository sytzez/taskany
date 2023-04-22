# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :project do
    title { 'Project title' }

    factory :project_with_tasks do
      transient do
        tasks_count { 5 }
      end

      tasks do
        Array.new(tasks_count) { association :task }
      end
    end
  end
end

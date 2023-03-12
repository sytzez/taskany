FactoryBot.define do
  factory :task do
    project { nil }
    user { nil }
    title { "MyString" }
    description { "MyText" }
    story_points { 1 }
  end
end

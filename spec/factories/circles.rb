FactoryBot.define do
  factory :circle do
    sequence(:name, "サークル_1")
    state { :unpublish }
    association :user
  end
end

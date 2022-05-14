FactoryBot.define do
  factory :user do
    sequence(:line_user_id) { |n| "user_test_line_id_#{n}" }
    sequence(:name, "ユーザー_1")
  end
end

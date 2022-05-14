FactoryBot.define do
  factory :event do
    sequence(:name, "イベント_1")
    association :circle
  end
end

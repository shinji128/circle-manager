FactoryBot.define do
  factory :match do
    state { :unfixed }
    sequence(:user_a, "user_a_1")
    sequence(:user_b, "user_b_1")
    sequence(:user_c, "user_c_1")
    sequence(:user_d, "user_d_1")
    association :event
  end
end

FactoryBot.define do
  factory :user_stretch do
    association :user
    association :stretch
    completed_count { 0 }
    last_completed_at { nil }
  end
end

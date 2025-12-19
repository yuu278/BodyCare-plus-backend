FactoryBot.define do
  factory :stretch do
    name { '首回しストレッチ' }
    description { '首周りの筋肉をほぐすストレッチです。' }
    target_area { 'neck' }
    body_part { 'neck' }
    pain_type { ['痛み'] }
    duration { ['1ヶ月未満'] }
    job_type { ['sitting_work'] }
    exercise_habit { ['some_exercise'] }
    posture_habit { ['hunched_shoulders'] }
  end
end

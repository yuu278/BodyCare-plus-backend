FactoryBot.define do
  factory :body_assessment do
    association :user
    pain_area { 'neck' }
    pain_types { ['痛み'] }
    duration { ['1ヶ月未満'] }
    job_types { ['sitting_work'] }
    exercise_habits { ['some_exercise'] }
    posture_habits { ['hunched_shoulders'] }
  end
end
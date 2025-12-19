class BodyAssessment < ApplicationRecord
  belongs_to :user

  # 必須項目のバリデーション
  validates :pain_area, presence: true
  validates :pain_types, presence: true
  validates :duration, presence: true
  validates :job_types, presence: true
  validates :exercise_habits, presence: true
  validates :posture_habits, presence: true
end

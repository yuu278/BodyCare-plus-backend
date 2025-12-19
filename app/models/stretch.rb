class Stretch < ApplicationRecord
  PAIN_TYPES = %w[重だるさ 痛み 痺れ].freeze
  DURATIONS = %w[数日以内 1ヶ月未満 1ヶ月以上].freeze
  JOB_TYPES = %w[sitting_work standing_work both].freeze
  EXERCISE_HABITS = %w[no_exercise some_exercise regular_exercise].freeze
  POSTURE_HABITS = %w[hunched_shoulders arched_waist slouching straight_neck straight_back nothing].freeze

  has_many :user_stretches, dependent: :destroy
  has_many :users, through: :user_stretches

  validates :name, :description, :target_area, presence: true

  scope :for_area, ->(area) { where("target_area LIKE ?", "%#{area}%") }

  scope :matching, -> (assessment) {
    stretches = all
    stretches = stretches.where(body_part: assessment.pain_area) if assessment.pain_area.present?
    stretches = stretches.where("pain_type @> ?", assessment.pain_types.to_json) if assessment.pain_types.present?
    stretches = stretches.where("duration @> ?", assessment.duration.to_json) if assessment.duration.present?
    stretches = stretches.where("job_type @> ?", assessment.job_types.to_json) if assessment.job_types.present?
    stretches = stretches.where("exercise_habit @> ?", assessment.exercise_habits.to_json) if assessment.exercise_habits.present?
    stretches = stretches.where("posture_habit @> ?", assessment.posture_habits.to_json) if assessment.posture_habits.present?
    stretches
  }

  # 柔軟性マッチング（段階的検索）
  def self.flexible_matching(assessment)
    base_scope = where(body_part: assessment.pain_area)

    is_postgres = ActiveRecord::Base.connection.adapter_name.downcase.include?("postgres")

    to_json_array = ->(v) { Array(v).to_json }

    apply_condition = lambda do |scope, column, value|
      return scope unless value.present?

      if is_postgres
        scope.where("#{column} @> ?", to_json_array.call(value))
      else
        scope.where("JSON_SEARCH(#{column}, 'one', ?) IS NOT NULL", value)
      end
    end

    # 1. 完全一致
    step1 = base_scope
    step1 = apply_condition.call(step1, "pain_type", assessment.pain_types)
    step1 = apply_condition.call(step1, "duration", assessment.duration)
    step1 = apply_condition.call(step1, "job_type", assessment.job_types)
    step1 = apply_condition.call(step1, "exercise_habit", assessment.exercise_habits)
    step1 = apply_condition.call(step1, "posture_habit", assessment.posture_habits)
    return step1 if step1.exists?

    # 2. duration 無視
    step2 = base_scope
    step2 = apply_condition.call(step2, "pain_type", assessment.pain_types)
    step2 = apply_condition.call(step2, "job_type", assessment.job_types)
    step2 = apply_condition.call(step2, "exercise_habit", assessment.exercise_habits)
    step2 = apply_condition.call(step2, "posture_habit", assessment.posture_habits)
    return step2 if step2.exists?

    # 3. duration + exercise_habit 無視
    step3 = base_scope
    step3 = apply_condition.call(step3, "pain_type", assessment.pain_types)
    step3 = apply_condition.call(step3, "job_type", assessment.job_types)
    step3 = apply_condition.call(step3, "posture_habit", assessment.posture_habits)
    return step3 if step3.exists?

    # 4. duration + job_type + exercise_habit 無視
    step4 = base_scope
    step4 = apply_condition.call(step4, "pain_type", assessment.pain_types)
    step4 = apply_condition.call(step4, "posture_habit", assessment.posture_habits)
    return step4 if step4.exists?

    # 5. pain_type のみ
    fallback = base_scope
    fallback = apply_condition.call(fallback, "pain_type", assessment.pain_types)
    fallback
  end
end

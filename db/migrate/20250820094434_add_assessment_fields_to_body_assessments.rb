class AddAssessmentFieldsToBodyAssessments < ActiveRecord::Migration[6.1]
  def change
    remove_column :body_assessments, :pain_area, :string if column_exists?(:body_assessments, :pain_area)
    remove_column :body_assessments, :pain_types, :string if column_exists?(:body_assessments, :pain_types)
    remove_column :body_assessments, :duration, :string if column_exists?(:body_assessments, :duration)
    remove_column :body_assessments, :job_types, :string if column_exists?(:body_assessments, :job_types)
    remove_column :body_assessments, :exercise_habits, :string if column_exists?(:body_assessments, :exercise_habits)
    remove_column :body_assessments, :posture_habits, :string if column_exists?(:body_assessments, :posture_habits)

    add_column :body_assessments, :pain_area, :string
    add_column :body_assessments, :pain_types, :json
    add_column :body_assessments, :duration, :json
    add_column :body_assessments, :job_types, :json
    add_column :body_assessments, :exercise_habits, :json
    add_column :body_assessments, :posture_habits, :json
  end
end

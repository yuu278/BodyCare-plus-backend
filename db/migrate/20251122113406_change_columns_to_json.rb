class ChangeColumnsToJson < ActiveRecord::Migration[7.1]
  def change
    # text型からjson型に変更
    change_column :body_assessments, :pain_types, :json
    change_column :body_assessments, :duration, :json
    change_column :body_assessments, :job_types, :json
    change_column :body_assessments, :exercise_habits, :json
    change_column :body_assessments, :posture_habits, :json
  end
end

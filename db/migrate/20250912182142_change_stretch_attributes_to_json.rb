class ChangeStretchAttributesToJson < ActiveRecord::Migration[7.1]
  def change
    change_column :stretches, :pain_type, :json, using: 'pain_type::json'
    change_column :stretches, :duration, :json, using: 'duration::json'
    change_column :stretches, :job_type, :json, using: 'job_type::json'
    change_column :stretches, :exercise_habit, :json, using: 'exercise_habit::json'
    change_column :stretches, :posture_habit, :json, using: 'posture_habit::json'
  end
end

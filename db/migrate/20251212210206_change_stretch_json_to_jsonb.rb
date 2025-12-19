class ChangeStretchJsonToJsonb < ActiveRecord::Migration[7.1]
  def change
    # PostgreSQL のときだけ JSONB へ変換
    if ActiveRecord::Base.connection.adapter_name == "PostgreSQL"
      change_column :stretches, :pain_type, :jsonb, using: 'pain_type::jsonb'
      change_column :stretches, :job_type, :jsonb, using: 'job_type::jsonb'
      change_column :stretches, :exercise_habit, :jsonb, using: 'exercise_habit::jsonb'
      change_column :stretches, :posture_habit, :jsonb, using: 'posture_habit::jsonb'
    else
      say "Skipping JSONB conversion because MySQL does not support jsonb."
    end
  end
end

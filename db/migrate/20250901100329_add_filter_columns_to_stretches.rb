class AddFilterColumnsToStretches < ActiveRecord::Migration[7.1]
  def change
    add_column :stretches, :pain_type, :string
    add_column :stretches, :job_type, :string
    add_column :stretches, :exercise_habit, :string
    add_column :stretches, :posture_habit, :string
    add_column :stretches, :duration, :string
  end
end

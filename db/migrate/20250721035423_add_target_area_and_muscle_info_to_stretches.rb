class AddTargetAreaAndMuscleInfoToStretches < ActiveRecord::Migration[7.1]
  def change
    add_column :stretches, :muscle_info, :text
  end
end

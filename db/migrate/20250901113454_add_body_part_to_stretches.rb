class AddBodyPartToStretches < ActiveRecord::Migration[7.1]
  def change
    add_column :stretches, :body_part, :string
  end
end

class CreateUserStretches < ActiveRecord::Migration[7.1]
  def change
    create_table :user_stretches do |t|
      t.references :user, null: false, foreign_key: true
      t.references :stretch, null: false, foreign_key: true
      t.boolean :recommended
      t.integer :completed_count
      t.datetime :last_completed_at

      t.timestamps
    end
  end
end

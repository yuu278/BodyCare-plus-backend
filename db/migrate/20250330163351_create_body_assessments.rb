class CreateBodyAssessments < ActiveRecord::Migration[7.1]
  def change
    create_table :body_assessments do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :assessment_date
      t.timestamps
    end
  end
end

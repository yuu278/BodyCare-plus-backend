class CreateStretches < ActiveRecord::Migration[7.1]
  def change
    create_table :stretches do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.string :video_url
      t.string :target_area

      t.timestamps
    end
  end
end

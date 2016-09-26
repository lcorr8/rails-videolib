class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.string :user_id
      t.string :video_ids

      t.timestamps null: false
    end
  end
end

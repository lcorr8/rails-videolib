class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :link
      t.string :year
      t.string :watched, default: "no"
      t.string :embed_link
      t.string :section_id
      t.string :note_ids
      t.string :user_id

      t.timestamps null: false
    end
  end
end

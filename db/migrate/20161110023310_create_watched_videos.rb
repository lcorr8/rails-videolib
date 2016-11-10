class CreateWatchedVideos < ActiveRecord::Migration
  def change
    create_table :watched_videos do |t|
      t.integer :video_id
      t.integer :user_id
      t.boolean :watched, default: false

      t.timestamps null: false
    end
  end
end

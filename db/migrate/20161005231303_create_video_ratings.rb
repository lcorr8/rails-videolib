class CreateVideoRatings < ActiveRecord::Migration
  def change
    create_table :video_ratings do |t|
      t.string :reason
      t.integer :video_id
      t.integer :rating_id

      t.timestamps null: false
    end
  end
end

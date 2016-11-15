class AddUsersToVideoRatings < ActiveRecord::Migration
  def change
    add_column :video_ratings, :user_id, :integer
  end
end

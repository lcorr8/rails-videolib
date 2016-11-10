class RemoveUserIdFromVideos < ActiveRecord::Migration
  def up
    remove_column :videos, :user_id, :string
  end
  def down
    add_column :videos, :user_id, :string
  end
end

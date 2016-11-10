class RemoveWatchedFromVideos < ActiveRecord::Migration
  def up
    remove_column :videos, :watched, :string
  end
    def down
    add_column :videos, :watched, :string
  end
end
